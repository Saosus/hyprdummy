#!/bin/bash
BAT=$(upower -i $(upower -e | grep BAT) | grep percentage | awk '{print $2}')
echo $BAT
