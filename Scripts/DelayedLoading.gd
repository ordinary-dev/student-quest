# Loads scene after delay

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Node

export (String, FILE, "*.tscn") var next_scene
export (float, 0.0, 5.0) var delay = 0.0
export (bool) var transition_in = true
export (bool) var transition_out = true


func _ready() -> void:
	if delay > 0.0:
		yield(get_tree().create_timer(delay), "timeout")
	load_scene()


func load_scene() -> void:
	SCENES.load_scene(
		next_scene, transition_in, transition_out)
