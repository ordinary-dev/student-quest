# Show dialog

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Node

export (String, FILE, "*.json") var dialog_path

export (bool) var enable_delay = false
export (float) var delay = 2.0

export (bool) var load_scene = false
export (String, FILE, "*.tscn") var scene_path
export (float) var loading_delay = 0.0


func _ready() -> void:
	if enable_delay:
		yield(get_tree().create_timer(delay), "timeout")
	if load_scene:
		DIALOG.show_dialog(dialog_path, get_path(), "load_next_scene")
	else:
		DIALOG.show_dialog(dialog_path)


func load_next_scene() -> void:
	if loading_delay > 0:
		yield(get_tree().create_timer(loading_delay), "timeout")
	SCENES.load_scene(scene_path)
