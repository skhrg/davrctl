#!/bin/bash

ip=$1
port=23
tcp=/dev/tcp/$ip/$port
cmd=$2

if [ "$cmd" = "volup" ];
then
    echo "MVUP" >$tcp
elif [ "$cmd" = "voldown" ];
then
    echo "MVDOWN" >$tcp
elif [ "$cmd" = "mute" ];
then
    mute=$(cat <(echo MU?) <(sleep .5) | nc $ip $port | tr -d '\r')
    if [ "$mute" = "MUOFF" ];
    then
        echo "MUON" >$tcp
    else
        echo "MUOFF" >$tcp
    fi
    echo $mute
else
    response=$(cat <(echo "${@:2}") <(sleep .5) | nc $ip $port | tr -d '\r')
    echo $response
fi

