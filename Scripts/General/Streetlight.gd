# Streetlight

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node2D

export (bool) var enable_light = true setget set_state

onready var light_source = $LightSource


func set_state(val:bool) -> void:
	light_source.visible = val
