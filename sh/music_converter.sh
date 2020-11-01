#!/bin/sh

# Settings
BITRATE="256k"
CODEC="libvorbis"
EXT=".ogg"

# Go to music directory
SAVED_PWD=$PWD
SCRIPT_DIR=`dirname "$(readlink -f "$0")"`
cd $SCRIPT_DIR
cd ../Audio/Music


for i in ".wav" ".mp3"
do
    find . -name "*$i" | while read line; do
	NEWFILE=${line/$i/$EXT}
	echo -ne "\r\033[KConverting $line..."
	if [ ! -f $NEWFILE ]; then
		ffmpeg -nostdin -y -i "$line" -ac 2 -ar 44100 -b:a $BITRATE -c:a $CODEC "$NEWFILE" &> /dev/null
	fi
    done
done

echo -e "\r\033[KDone"

# Return to original directory
cd $SAVED_PWD
