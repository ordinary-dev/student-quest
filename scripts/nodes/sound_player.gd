extends Node
class_name SoundPlayer

# Play sound in background
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export_file var file
@export_range(0.0, 10.0) var delay: float = 0.0


func _ready() -> void:
	assert(FileAccess.file_exists(file))
	if delay > 0:
		await get_tree().create_timer(delay).timeout
	FX.play_sound(load(file))
