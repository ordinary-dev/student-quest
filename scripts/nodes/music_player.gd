extends Node
class_name MusicPlayer

# Play music in background
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.ogg") var file
export (float, 0.0, 5.0) var delay = 0.0


func _ready() -> void:
	assert(File.new().file_exists(file))
	if delay > 0:
		yield(get_tree().create_timer(delay), "timeout")
	MUSIC.play_sound(file)
