#! /bin/bash
set -x

# Update package list and install updates
sudo apt update && sudo apt upgrade

# Install dependencies
sudo apt install ffmpeg unzip tree

# Directory fo zipfiles
mkdir ../zipfiles

# Directory for compiled videos 
mkdir ../videos

# Directory for png sequences
mkdir ../png
