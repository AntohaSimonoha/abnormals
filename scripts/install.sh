#! /bin/bash
set -x

# Update package list and install updates
sudo apt update && sudo apt upgrade

# Install dependencies
sudo apt install ffmpeg unzip unrar tree

# Directory fo zipfiles
mkdir ../zipfiles

# Directory for compiled videos 
mkdir ../videos
mkdir ../videos/end
mkdir ../videos/start
mkdir ../videos/full
mkdir ../videos/loop

# Directory for png sequences
mkdir ../png
