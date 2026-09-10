#!/bin/bash

brightness=$(brightnessctl -m | awk -F ',' '{print substr($4, 1, length($4)-1)}')
echo $brightness
