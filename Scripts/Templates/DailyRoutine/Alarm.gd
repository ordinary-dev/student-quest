# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Node2D

export (String, FILE, "*.tscn") var scene_path


func load_scene() -> void:
	SCENES.load_scene(scene_path, false, false)


func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		load_scene()
