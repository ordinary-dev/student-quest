# Stairs

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Node2D

export (String, FILE, "*.tscn") var dialog
export (String, FILE, "*.tscn") var secret


func go() -> void:
	if TEMP.is_saved("stairs_secret"):
		SCENES.load_scene(secret)
	else:
		TEMP.save("stairs_secret", true)
		SCENES.load_scene(dialog)
