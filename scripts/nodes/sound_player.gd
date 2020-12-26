extends Node
class_name SoundPlayer

# Play sound in background
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE) var file
export (float, 0.0, 10.0) var delay = 0.0


func _ready() -> void:
	assert(File.new().file_exists(file))
	if delay > 0:
		yield(get_tree().create_timer(delay), "timeout")
	FX.play_sound(load(file))
