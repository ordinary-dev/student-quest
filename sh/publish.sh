#!/bin/sh

# Publish new build to itch.io

version=5.0

cd Builds
# Android
butler push Android/student-quest.apk pixeltrain/student-quest:android --userversion $version
# Linux
butler push Linux pixeltrain/student-quest:linux --userversion $version
# MacOS
butler push MacOS/student-quest.zip pixeltrain/student-quest:macos --userversion $version
# Windows
butler push Windows pixeltrain/student-quest:windows --userversion $version
