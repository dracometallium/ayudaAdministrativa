#!/bin/bash
#
#script to record a screen window with avconv or ffmpeg. 
#uses xwininfo to get info about the window to record
#based on https://gist.github.com/anonymous/3927068 (http://www.youtube.com/watch?v=_XDa1ahl7fw)

name=$(cat /dev/urandom | tr -dc a-zA-Z0-9 | head -c 20)
width=640
height=480
win_geo="${width}x${height}"

message='MOVER esta ventana hasta la sección de
la pantalla que se quiere grabar. Luego
presione "LISTO" en la otra ventana.'

echo "$message" |
    xmessage -geom "$win_geo" -name "$name" -file - -button "NO CERRAR"&

message2='Presione LISTO una vez que la otra
ventana este ubicada en el área elegida'
echo "$message2" |xmessage -file - -button "LISTO"

info=$(xwininfo -name "$name" -frame)

xid=$(echo "$info" |
    grep "Window id:" |
    sed -e 's/.*0x/0x/;s/ .*//')

win_xy=$(echo "$info" |
    grep "Corners: *+[0-9][0-9]*" |
    sed -e 's/.*Corners:\s*+//;s/+/,/;s/ .*//')

xkill -id "$xid"

#You should check what video device you have available
ffmpeg -f x11grab -y -r 15 -s "$win_geo" -i "$DISPLAY"+"$win_xy" \
    -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0
