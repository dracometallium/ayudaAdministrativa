#!/bin/bash
#
#script to record a screen window with avconv or ffmpeg. 
#uses xwininfo to get info about the window to record
#based on https://gist.github.com/anonymous/3927068 (http://www.youtube.com/watch?v=_XDa1ahl7fw)

INFO=$(xwininfo -frame)

WIN_GEO=$(echo $INFO | grep -oEe 'geometry [0-9]+x[0-9]+' |\
    grep -oEe '[0-9]+x[0-9]+')
WIN_XY=$(echo $INFO | grep -oEe 'Corners:\s+\+[0-9]+\+[0-9]+' |\
    grep -oEe '[0-9]+\+[0-9]+' | sed -e 's/+/,/' )


#checks if width and height are odd numbers and adds +1 if true
#because libx264 complaints if width/height are not divisible by 2

WIDTH=`echo $WIN_GEO| cut -d'x' -f 1`
HEIGHT=`echo $WIN_GEO| cut -d'x' -f 2`

REM=$(( $HEIGHT % 2 ))
if [ $REM -ne 0 ]
then
  HEIGHT=$(( HEIGHT + 1 ))
fi


REM=$(( $WIDTH % 2 ))
if [ $REM -ne 0 ]
then
  WIDTH=$(( WIDTH + 1 ))
fi

WIN_GEO="${WIDTH}x${HEIGHT}"

#You should check what video device you have available
ffmpeg -f x11grab -y -r 15 -s $WIN_GEO -i "$DISPLAY"+$WIN_XY \
    -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0

#original command
#ffmpeg -f x11grab -y -r 15 -s $WIN_GEO -i :0.0+$WIN_XY -vcodec ffv1 -sameq -f alsa -ac 2 -i pulse -acodec ac3 -threads 2 $1.avi
