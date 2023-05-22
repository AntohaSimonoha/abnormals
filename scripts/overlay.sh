#! /bin/bash

PNG_DIR='../png/'

# FFMPEG variables
FPS=30
RES="1920:800"
CODEC="prores_ks"
PIXFMT="yuva444p10"
VENDOR="ap10"
PROFILE_NUM=4

END="../videos/AkanatinaEND.mov"
FULL="../videos/_Nutel1a_FULL.mov"
START="../videos/AkanatinaSTART.mov"
PATH_TO_SAVE="../videos/AkanatinaLOOP.mov"

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

	#-vcodec "$CODEC"\
       	#-pix_fmt "$PIXFMT"\
       	#-vendor "$VENDOR"\
       	#-profile:v "$PROFILE_NUM"\
	#"[0:v]setpts=PTS+6.6666/TB[end];[end][1:v]overlay[full_end];[full_end][2:v]overlay"\

overlay "$END" "$FULL" "$START" "$PATH_TO_SAVE"

#for ENTRY in "$PNG_DIR"*/
#do
	#NAME=$(echo "$ENTRY" | cut -d"/" -f3);
	#echo "$NAME";

	#PATH_TO_FILE="../png/$NAME/%04d.png"
	#echo "$PATH_TO_FILE"

	#PATH_TO_SAVE_FULL="../videos/"$NAME"FULL.mov"
	#echo "$PATH_TO_SAVE"

	#PATH_TO_SAVE_START="../videos/"$NAME"START.mov"
	#echo "$PATH_TO_SAVE"

	#PATH_TO_SAVE_END="../videos/"$NAME"END.mov"
	#echo "$PATH_TO_SAVE"

	#encode "$START" "$END" "$PATH_TO_SAVE_FULL"
	#encode "$(($START + 200))" "$END" "$PATH_TO_SAVE_START"
	#encode "$START" "$(($END - 200))" "$PATH_TO_SAVE_END"
#done
