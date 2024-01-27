extends Node2D

# Loads scene number 0 with 2 buttons
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export_file("*.tscn") var btn_scene_path


# Called by the animation player
func load_scene(_anim_name) -> void:
	assert(FileAccess.file_exists(btn_scene_path))
	var tmp = load(btn_scene_path).instantiate()
	add_child(tmp)
