#!/bin/bash

<<<<<<< HEAD
eww=/home/cppyli/Documents/githubClones/eww/target/release/eww

if [[ -z $($eww active-windows | grep 'datepanel') ]]; then
    $eww open datepanel && $eww update date-revealer=true
else
    $eww update date-revealer=false
    (sleep 0.2 && $eww close datepanel) &
=======
if [[ -z $(eww active-windows | grep 'datepanel') ]]; then
    eww open datepanel && eww update date-revealer=true
else
    eww update date-revealer=false
    (sleep 0.2 && eww close datepanel) &
>>>>>>> 9d211cf (reinitialized repo)
fi

