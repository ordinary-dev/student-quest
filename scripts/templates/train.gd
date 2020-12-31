extends Node2D

# Loads the scene after the train passes
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.tscn") var scene_path


func _on_animation_finished(_anim_name):
	SCENES.load_scene(scene_path, false, false)
