#!/bin/bash


if [[ -z $(eww active-windows | grep 'music-box') ]]; then
    eww open music-box && eww update music-revealer=true
else
    eww update music-revealer=false
    (sleep 0.2 && eww close music-box) &
fi
