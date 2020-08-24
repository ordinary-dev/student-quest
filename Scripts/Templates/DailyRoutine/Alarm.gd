# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node2D

export (String, FILE, "*.tscn") var scene_path


func load_scene() -> void:
	SCENES.load_scene(scene_path, false, false)


func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		load_scene()
