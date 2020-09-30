# Load scene

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends "res://Scripts/Triggers/TriggerBase.gd"

export (String, FILE, "*.tscn") var scene
export (bool) var fade_in = true
export (bool) var fade_out = true


func action() -> void:
	SCENES.load_scene(scene, fade_in, fade_out)


func _ready() -> void:
	action = funcref(self, "action")
