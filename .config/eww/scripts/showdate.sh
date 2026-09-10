#!/bin/bash

if [[ -z $(eww active-windows | grep 'datepanel') ]]; then
    eww open datepanel && eww update date-revealer=true
else
    eww update date-revealer=false
    (sleep 0.2 && eww close datepanel) &
fi

