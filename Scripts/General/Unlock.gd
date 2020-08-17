# Unlock stage

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Node

export (int) var subchapter_id = 1


func _ready() -> void:
	if GLOBAL.progress < subchapter_id:
		GLOBAL.progress = subchapter_id
		GLOBAL.write_settings()
