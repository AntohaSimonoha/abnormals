#! /bin/bash

# Color variables
GREEN='\033[0;32m'
NC='\033[0m' # No Color

ZIP="\.zip$"
RAR="\.rar$"

# Extract .png files from .zip's (../zipfiles/ARTISTNAME.zip)
# to (../png/ARTISTNAME/*.png)
extract () {

	for file in ../zipfiles/*;
	do
		name=$(echo "$file" | cut -d'/' -f3 | cut -d'.' -f1)

		if [[ $file =~ $ZIP ]]; then
			# '-q' quiet, '-n' do not extract existing files,
			# '-d' output directory, '-j' flatten
			
			unzip -q -n -j "$file" -d ../png/"$name"
		elif [[ $file =~ $RAR ]]; then
			unrar e "$file" ../png/"$name"/
		fi
		
		#echo "$file"

		check_dir
		rename
	done
}

# Check if directory exists. If not, create the directory.
check_dir () {

	if [ ! -d $"../png/$name" ]
	then
		printf "${GREEN} Making directory for $name. ${NC}\n"
		mkdir $"../png/$name"
	fi
}

# Rename files with sequential names. 0001.png, 0002.png...NNNN.png
rename () {

	index=1

	for file in ../png/"$name"/*.png;
	do
		path=$(echo "$file" | cut -d'/' -f1-3)
		new_name=$(printf "%04d.png" "$index") #04 pad to length of 4

		mv -n -- "$file" "$path/$new_name"
		let index=index+1
	done
}

extract

