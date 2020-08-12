# The script to quit the game

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Control


func _ready():
	# Save data
	GLOBAL.write_settings()
	# Quit
	get_tree().quit()
