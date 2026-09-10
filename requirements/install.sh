#!/bin/bash
set -euo pipefail

# Цвета для вывода
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Функции логирования
log()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error(){ echo -e "${RED}[ERROR]${NC} $1" >&2; }

# trap для отлова ошибок с номером строки
trap 'error "Ошибка в строке $LINENO"' ERR

# Проверка, что скрипт не запущен от root
if [ "$EUID" -eq 0 ]; then
    error "Не запускайте скрипт от root. Используйте обычного пользователя с правами sudo."
    exit 1
fi

# Определяем директорию, где лежит скрипт, и папку с файлами
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOWNLOAD_DIR="$SCRIPT_DIR/download"

# Имена файлов (все они должны лежать в $DOWNLOAD_DIR)
PACMAN_LIST="pacman_packages.txt"
YAY_LIST="yay_packages.txt"
GITCLONES_LIST="gitclones.txt"
USER_GROUPS="usergroups.txt"
SYS_SERVICES="enabled_services.txt"
USER_SERVICES="enabled_user_services.txt"

# Проверяем наличие всех необходимых файлов
for f in "$PACMAN_LIST" "$YAY_LIST" "$GITCLONES_LIST" "$USER_GROUPS" "$SYS_SERVICES" "$USER_SERVICES"; do
    if [ ! -f "$DOWNLOAD_DIR/$f" ]; then
        error "Файл $DOWNLOAD_DIR/$f не найден."
        exit 1
    fi
done

log "Начало установки системы..."

# 1. Обновление системы
log "Обновление системы..."
sudo pacman -Syu --noconfirm

# 2. Включение multilib репозитория (нужен для lib32 пакетов)
log "Проверка и включение multilib репозитория..."
if ! grep -q "^\[multilib\]" /etc/pacman.conf; then
    log "Включение multilib репозитория..."
    sudo sed -i '/\[multilib\]/,/Include/ s/^#//' /etc/pacman.conf
    sudo pacman -Sy --noconfirm
else
    log "Multilib репозиторий уже включен."
fi

# 3. Установка yay (если ещё не установлен)
if ! command -v yay &> /dev/null; then
    log "Установка yay из AUR..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
else
    log "yay уже установлен."
fi

# 4. Установка пакетов из официального репозитория
log "Установка пакетов из pacman..."

# Создаем временный файл с отфильтрованным списком пакетов (без комментариев и пустых строк)
grep -v '^#' "$DOWNLOAD_DIR/$PACMAN_LIST" | grep -v '^[[:space:]]*$' > /tmp/pacman_packages_clean.txt

# Проверяем наличие конфликтующих пакетов и удаляем iptables если он есть (для iptables-nft)
if grep -q "iptables-nft" /tmp/pacman_packages_clean.txt && pacman -Q iptables &>/dev/null; then
    log "Обнаружен конфликт: будет установлен iptables-nft. Удаляем обычный iptables..."
    sudo pacman -Rdd --noconfirm iptables
fi

# Пытаемся установить все пакеты сразу
log "Установка всех пакетов из списка..."
if ! sudo pacman -S --needed --noconfirm --overwrite='*' - < /tmp/pacman_packages_clean.txt; then
    error "Не удалось установить некоторые пакеты. Проверьте вывод выше."
    exit 1
fi

rm -f /tmp/pacman_packages_clean.txt

# 5. Установка пакетов из AUR через yay
log "Установка пакетов из AUR..."
while IFS= read -r pkg; do
    # Пропускаем пустые строки и комментарии
    if [[ -z "$pkg" || "$pkg" =~ ^# ]]; then
        continue
    fi
    
    log "Установка $pkg из AUR..."
    if ! yay -S --needed --noconfirm "$pkg" 2>/dev/null; then
        warn "Не удалось установить $pkg из AUR, пропускаем."
    fi
done < "$DOWNLOAD_DIR/$YAY_LIST"

# 6. Клонирование дополнительных репозиториев
log "Клонирование git-репозиториев..."
GIT_DIR="$HOME/git"
mkdir -p "$GIT_DIR"

while IFS= read -r line; do
    # Удаляем возможный обратный слеш в конце строки (из-за переноса)
    line=$(echo "$line" | sed 's/\\$//')
    # Пропускаем пустые строки и комментарии
    if [[ -z "$line" || "$line" =~ ^# ]]; then
        continue
    fi
    # Проверяем, что строка начинается с "git clone"
    if [[ "$line" =~ ^git\ clone\ (.*)$ ]]; then
        url="${BASH_REMATCH[1]}"
        repo_name=$(basename "$url" .git)
        target_dir="$GIT_DIR/$repo_name"
        if [ -d "$target_dir" ]; then
            warn "Репозиторий $repo_name уже существует, пропускаем."
        else
            log "Клонирование $url в $target_dir"
            git clone "$url" "$target_dir"
        fi
    else
        warn "Не удалось распознать команду (пропускаем): $line"
    fi
done < "$DOWNLOAD_DIR/$GITCLONES_LIST"

# 7. Добавление пользователя в группы
log "Добавление пользователя в группы..."
current_user=$(whoami)
# Читаем файл групп, преобразуем в строку через запятую (удаляем лишние пробелы и пустые строки)
groups_to_add=$(grep -v '^[[:space:]]*$' "$DOWNLOAD_DIR/$USER_GROUPS" | tr '\n' ',' | sed 's/,$//')
if [ -n "$groups_to_add" ]; then
    sudo usermod -aG "$groups_to_add" "$current_user"
    log "Пользователь $current_user добавлен в группы: $groups_to_add"
else
    warn "Нет групп для добавления (файл пуст)."
fi

# 8. Включение системных сервисов
log "Включение системных сервисов..."
# Извлекаем имена сервисов (первое поле строк, содержащих .service)
mapfile -t sys_services < <(grep '\.service' "$DOWNLOAD_DIR/$SYS_SERVICES" | awk '{print $1}' | grep -v '@' || true)
for svc in "${sys_services[@]}"; do
    if systemctl list-unit-files "$svc" &>/dev/null; then
        sudo systemctl enable "$svc"
        log "Системный сервис $svc включён."
    else
        warn "Системный сервис $svc не найден, пропускаем."
    fi
done

# 9. Включение пользовательских сервисов
log "Включение пользовательских сервисов..."
mapfile -t user_services < <(grep '\.service' "$DOWNLOAD_DIR/$USER_SERVICES" | awk '{print $1}' | grep -v '@' || true)
for svc in "${user_services[@]}"; do
    if systemctl --user list-unit-files "$svc" &>/dev/null; then
        systemctl --user enable "$svc"
        log "Пользовательский сервис $svc включён."
    else
        warn "Пользовательский сервис $svc не найден, пропускаем."
    fi
done

# 10. Копирование .vimrc и .zshrc (если они есть в download)
log "Копирование конфигурационных файлов..."
if [ -f "$DOWNLOAD_DIR/.vimrc" ]; then
    cp "$DOWNLOAD_DIR/.vimrc" "$HOME/.vimrc"
    log ".vimrc скопирован в домашнюю директорию."
fi

if [ -f "$DOWNLOAD_DIR/.zshrc" ]; then
    cp "$DOWNLOAD_DIR/.zshrc" "$HOME/.zshrc"
    log ".zshrc скопирован в домашнюю директорию."
fi

log "Установка завершена успешно!"
echo -e "${YELLOW}Важные замечания:${NC}"
echo "1. Для применения групп пользователя необходимо перелогиниться или перезагрузить систему."
echo "2. Проверьте, что все сервисы запущены: 'systemctl status <сервис>' и 'systemctl --user status <сервис>'."
echo "3. Для применения конфигураций Hyprland и тем перезапустите сессию или выполните 'hyprctl reload'."
