# Streetlight

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Node2D

export (bool) var enable_light = true setget set_state

onready var light_source = $LightSource


func set_state(val:bool) -> void:
	light_source.visible = val
