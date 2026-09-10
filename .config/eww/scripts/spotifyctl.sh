#!/bin/bash

<<<<<<< HEAD
eww=/home/cppyli/Documents/githubClones/eww/target/release/eww

if [[ -z $($eww active-windows | grep 'music-box') ]]; then
    $eww open music-box && $eww update music-revealer=true
else
    $eww update music-revealer=false
    (sleep 0.2 && $eww close music-box) &
=======

if [[ -z $(eww active-windows | grep 'music-box') ]]; then
    eww open music-box && eww update music-revealer=true
else
    eww update music-revealer=false
    (sleep 0.2 && eww close music-box) &
>>>>>>> 9d211cf (reinitialized repo)
fi
