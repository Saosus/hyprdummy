#!/bin/bash

<<<<<<< HEAD
<<<<<<< HEAD
eww=/home/cppyli/Documents/githubClones/eww/target/release/eww

if [[ -z $($eww active-windows | grep 'datepanel') ]]; then
    $eww open datepanel && $eww update date-revealer=true
else
    $eww update date-revealer=false
    (sleep 0.2 && $eww close datepanel) &
=======
=======
>>>>>>> 35089f2 (fixed pull issues)
if [[ -z $(eww active-windows | grep 'datepanel') ]]; then
    eww open datepanel && eww update date-revealer=true
else
    eww update date-revealer=false
    (sleep 0.2 && eww close datepanel) &
<<<<<<< HEAD
>>>>>>> 9d211cf (reinitialized repo)
=======
=======
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
>>>>>>> fca83c1 (reinitialized repo)
>>>>>>> 35089f2 (fixed pull issues)
fi

