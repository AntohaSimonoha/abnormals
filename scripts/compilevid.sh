#! /bin/bash

PNG_DIR='../png/'

# FFMPEG variables
FPS=30
RES="1920:800"
CODEC="prores_ks"
PIXFMT="yuva444p10"
VENDOR="ap10"
PROFILE_NUM=4
START=1
END=400

function encode {

	START_NUMBER=$1
	END_NUMBER=$2
	PATH_TO_SAVE=$3

	ffmpeg -start_number "$START_NUMBER"\
	-framerate "$FPS"\
       	-i "$PATH_TO_FILE"\
	-vcodec "$CODEC"\
       	-pix_fmt "$PIXFMT"\
       	-vendor "$VENDOR"\
	-vf scale="$RES"\
       	-profile:v "$PROFILE_NUM"\
	-frames:v "$END_NUMBER"\
       	"$PATH_TO_SAVE"
}

for ENTRY in "$PNG_DIR"*/
do
	NAME=$(echo "$ENTRY" | cut -d"/" -f3);
	echo "$NAME";

	PATH_TO_FILE="../png/$NAME/%04d.png"
	echo "$PATH_TO_FILE"

	PATH_TO_SAVE_FULL="../videos/full/"$NAME".mov"
	echo "$PATH_TO_SAVE"

	PATH_TO_SAVE_START="../videos/start/"$NAME".mov"
	echo "$PATH_TO_SAVE"

	PATH_TO_SAVE_END="../videos/end/"$NAME".mov"
	echo "$PATH_TO_SAVE"

	encode "$START" "$END" "$PATH_TO_SAVE_FULL"
	encode "$(($START + 200))" "$END" "$PATH_TO_SAVE_START"
	encode "$START" "$(($END - 200))" "$PATH_TO_SAVE_END"
done

