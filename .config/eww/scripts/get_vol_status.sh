#!/bin/bash
muted=$(wpctl get-volume @DEFAULT_SINK@ | grep -q MUTED && echo " " || echo " ")
echo "${muted}"
