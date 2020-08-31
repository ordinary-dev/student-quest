#!/bin/sh

# Usage: webp.sh original_image.png new_image.webp
# Convert any image to webp
# Install imagemagick before using this script

convert $1 -quality 100 -define webp:lossless=true -define webp:method=6 $2
