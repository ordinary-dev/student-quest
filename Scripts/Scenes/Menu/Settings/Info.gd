# Script to open links in browser

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Node


func open_site(link : String) -> void:
	var err = OS.shell_open(link)
	if err != OK:
		print("Can't open link!")


func open_store() -> void:
	open_site("https://pixeltrain.itch.io/student-quest")


func freesound() -> void:
	open_site("https://freesound.org/")


func zapsplat() -> void:
	open_site("https://www.zapsplat.com/")


func outgoing_hikikomori() -> void:
	open_site("https://www.youtube.com/channel/UC3yRCpfOE2zfTQsOHCH8wZw")
