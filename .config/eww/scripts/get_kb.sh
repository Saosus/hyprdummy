#!/bin/bash

CURRENT_KB="hyprctl devices | grep \"active keymap\" | tail -n 1 | awk '{print \$3}'"

if [[ $(eval $CURRENT_KB) == "English" ]]; then
        echo "English"
else
        echo "Russian"
fi


