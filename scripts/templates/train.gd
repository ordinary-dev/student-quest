extends Node2D

# Loads the scene after the train passes
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export_file("*.tscn") var scene_path


func _on_animation_finished(_anim_name):
	SCENES.load_scene(scene_path, false, false)
