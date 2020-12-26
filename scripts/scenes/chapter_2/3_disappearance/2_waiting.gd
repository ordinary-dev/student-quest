extends Node2D

# Loads scene number 0 with 2 buttons
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.tscn") var btn_scene_path


# Called by the animation player
func load_scene(_anim_name) -> void:
	assert(File.new().file_exists(btn_scene_path))
	var tmp = load(btn_scene_path).instance()
	add_child(tmp)
