# Play sound in background

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node

export (String, FILE) var file
export (float, 0.0, 10.0) var delay = 0.0


func _ready() -> void:
	if delay > 0:
		yield(get_tree().create_timer(delay), "timeout")
	FX.play_sound(load(file))
