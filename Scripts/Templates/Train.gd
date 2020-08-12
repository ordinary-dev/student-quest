# Train

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Node2D

export (String, FILE, "*.tscn") var scene_path


func _on_animation_finished(_anim_name):
	SCENES.load_scene(scene_path, false, false)
