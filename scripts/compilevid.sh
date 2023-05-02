#! /bin/bash

PNG_DIR='../png/'

for ENTRY in "$PNG_DIR"*/*/
do
	NAME=$(echo "$ENTRY" | cut -d"/" -f3);
	echo "$NAME";

	PATH_TO_FILE="../png/$NAME/Artistinimi/%04d.png"
	echo "$PATH_TO_FILE"

	PATH_TO_SAVE="../videos/$NAME.mov"
	echo "$PATH_TO_SAVE"

	ffmpeg -start_number 1 -framerate 30 -i "$PATH_TO_FILE"\
	-vcodec prores_ks -pix_fmt yuva444p10 -vendor ap10\
       	-profile:v 4 "$PATH_TO_SAVE"
done
