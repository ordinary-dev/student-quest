extends "res://scripts/triggers/advanced/base.gd"

# Loads the scene after confirmation
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export_file("*.tscn") var scene
@export var fade_in: bool = true
@export var fade_out: bool = true


func action() -> void:
	SCENES.load_scene(scene, fade_in, fade_out)
