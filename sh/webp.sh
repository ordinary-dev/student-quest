#!/bin/sh
convert $1 -quality 100 -define webp:lossless=true -define webp:method=6 $2
