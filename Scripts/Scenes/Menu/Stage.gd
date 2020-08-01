# Stage script

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends ColorRect

export (StreamTexture) var texture
export (String) var stage_name
export (bool) var enabled = false setget update_state
export (String, FILE, "*.tscn") var path_to_scene

onready var label = $MarginContainer/Content/Label
onready var image = $MarginContainer/Content/TextureRect
onready var btn = $Button


func update_state(val : bool) -> void:
	enabled = val
	if enabled:
		image.texture = texture
		label.text = stage_name
		btn.disabled = false
		color = Color("#232323")
	else:
		btn.disabled = true
		label.text = "../.."
		color = Color("#303030")


func _ready() -> void:
	update_state(enabled)


func _on_button_pressed() -> void:
	SCENES.load_scene(path_to_scene)
