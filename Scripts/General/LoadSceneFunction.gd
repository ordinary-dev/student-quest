# Template for triggers

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node2D

export (String, FILE, "*.tscn") var scene_path 


# Don't edit the function name
# without changing it in all triggers

func load_scene() -> void:
	SCENES.load_scene(scene_path)
