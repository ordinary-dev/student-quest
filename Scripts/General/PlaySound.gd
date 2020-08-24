# Play sound in background

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node

export (String, FILE) var file


func _ready() -> void:
	FX.play_sound(load(file))
