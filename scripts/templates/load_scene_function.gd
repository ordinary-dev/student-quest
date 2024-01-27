extends Node

# Template for triggers
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export_file("*.tscn") var scene_path 
@export var fade_in: bool = true
@export var fade_out: bool = true


# Don't edit the function name
# without changing it in all triggers
func load_scene() -> void:
	SCENES.load_scene(scene_path, fade_in, fade_out)
