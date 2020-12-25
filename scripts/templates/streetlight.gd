extends Node2D

# Streetlight
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

export (bool) var enable_light = true setget _set_state
onready var _light_source = $LightSource


func _set_state(val: bool) -> void:
	enable_light = val
	_light_source.visible = enable_light
