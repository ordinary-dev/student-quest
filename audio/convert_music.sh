#!/bin/sh


ffmpeg -i $1 -b:a 256k $2
