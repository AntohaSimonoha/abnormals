#! /bin/bash

PNG_DIR='../png/'

# FFMPEG variables
FPS=30
RES="1920:800"
CODEC="prores_ks"
PIXFMT="yuva444p10"
VENDOR="ap10"
PROFILE_NUM=4

function encode {

	ffmpeg -start_number 1\
	-framerate "$FPS"\
       	-i "$PATH_TO_FILE"\
	-vcodec "$CODEC"\
       	-pix_fmt "$PIXFMT"\
       	-vendor "$VENDOR"\
	-vf scale="$RES"\
       	-profile:v "$PROFILE_NUM"\
       	"$PATH_TO_SAVE"
}

for ENTRY in "$PNG_DIR"*/
do
	NAME=$(echo "$ENTRY" | cut -d"/" -f3);
	echo "$NAME";

	PATH_TO_FILE="../png/$NAME/%04d.png"
	echo "$PATH_TO_FILE"

	PATH_TO_SAVE="../videos/$NAME.mov"
	echo "$PATH_TO_SAVE"

	encode
done

