extends Node
class_name MusicPlayer

# Play music in background
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export_file("*.ogg") var file
@export_range(0.0, 5.0) var delay: float = 0.0


func _ready() -> void:
	assert(FileAccess.file_exists(file))
	if delay > 0:
		await get_tree().create_timer(delay).timeout
	MUSIC.play_sound(file)
