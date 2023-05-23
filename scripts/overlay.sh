#! /bin/bash

VIDEO_DIR='../videos/'

# FFMPEG variables
FPS=30
RES="1920:800"
CODEC="prores_ks"
PIXFMT="yuva444p10"
VENDOR="ap10"
PROFILE_NUM=4

function overlay {

	PATH_TO_FILE_END=$1
	PATH_TO_FILE_FULL=$2
	PATH_TO_FILE_START=$3
	PATH_TO_SAVE=$4

	ffmpeg -stream_loop 1 -i "$PATH_TO_FILE_END"\
       	-i "$PATH_TO_FILE_FULL"\
       	-i "$PATH_TO_FILE_START"\
	-filter_complex \
	"[0:v][1:v]overlay[full_end];[full_end][2:v]overlay"\
	-vcodec "$CODEC"\
       	-pix_fmt "$PIXFMT"\
       	-vendor "$VENDOR"\
       	-profile:v "$PROFILE_NUM"\
       	"$PATH_TO_SAVE"
}

for ENTRY in "$VIDEO_DIR"end/*
do
	END="$ENTRY"
	NAME=$(echo "${ENTRY::-4}" | cut -d"/" -f4)
	
	START=$(echo "$ENTRY" | awk 'BEGIN{FS=OFS="/"} {if (NR==1) {$3 = "start"}; print}') 
	FULL=$(echo "$ENTRY" | awk 'BEGIN{FS=OFS="/"} {if (NR==1) {$3 = "full"}; print}') 

	PATH_TO_SAVE="../videos/loop/$NAME.mov"

	echo "$START"
	echo "$FULL"
	echo "$END"
	echo "$PATH_TO_SAVE"

	overlay "$END" "$FULL" "$START" "$PATH_TO_SAVE"
done
