#!/bin/sh

## Remove old directory ##
rm -r Builds

## Create new ##
mkdir Builds
mkdir Builds/Android
mkdir Builds/Linux
mkdir Builds/MacOS
mkdir Builds/Windows

## Copy files ##
name=sq-v.$1
# Android
cp latest.apk Builds/Android/$name.apk
# Linux
cp latest.pck    Builds/Linux/$name.pck
cp latest.x86_64 Builds/Linux/$name.x86_64
# MacOS
cp latest.x86_64.zip Builds/MacOS/$name.zip
# Windows
cp latest.exe Builds/Windows/$name.exe
cp latest.pck Builds/Windows/$name.pck

## Butler ##
cd Builds
# Android
butler push Android/$name.apk pixeltrain/student-quest:android --userversion $1
# Linux
butler push Linux pixeltrain/student-quest:linux --userversion $1
# MacOS
butler push MacOS/$name.zip pixeltrain/student-quest:macos --userversion $1
# Windows
butler push Windows pixeltrain/student-quest:windows --userversion $1
