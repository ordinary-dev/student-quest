# Play music in background

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Node

export (String, FILE, "*.ogg") var file
export (float, 0.0, 5.0) var delay = 0.0


func _ready() -> void:
	if delay > 0:
		yield(get_tree().create_timer(delay), "timeout")
	MUSIC.play_sound(file)
