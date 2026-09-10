### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit

(( ${+_comps} )) && _comps[zinit]=_zinit

#Zinit plugins and snippets
zinit load zdharma-continuum/history-search-multi-word
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit -C -u

#Options
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

#aliases
alias c='clear'
alias grep='grep --color=auto'
alias la='ls -lah --color=auto'
alias rbt='reboot'
alias pwf='poweroff'
alias заебался='poweroff'
alias update='sudo pacman -Syyu'
alias qqen='pacman -Qqen' #pacman packages
alias qqem='pacman -Qqem' #AUR and other packages
alias open='xdg-open'
alias ff='fastfetch'

alias resnet='sudo systemctl restart iwd.service; sudo systemctl restart systemd-networkd.service; sudo systemctl restart systemd-resolved.service'
alias zapen='bash /opt/zapret-discord-youtube-linux/service.sh'
alias resstat='~/.config/hypr/scripts/statistic_message/reset_counter.sh'
alias resstat='~/.config/hypr/scripts/statistic_message/reset_counter.sh '
#alias eww='/home/cppyli/docs/githubClones/eww/target/release/eww'

#export
export PATH="$HOME/docs/githubClones/eww/target/release/:$PATH"
export PATH="${PATH}:${HOME}/python-env/bin"
export PATH=$PATH:/home/cppyli/.spicetify
export PATH="/home/cppyli/.local/bin:$PATH"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

#prompt
eval "$(starship init zsh)"

