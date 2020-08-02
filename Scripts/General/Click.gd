# Play random click sound

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Node

onready var audio_src = [
	$Click1,
	$Click2,
	$Click3
]

func play():
	var ind : int = randi() % 3
	audio_src[ind].play()
