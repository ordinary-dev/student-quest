# Function trigger

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends "res://Scripts/Triggers/TriggerBase.gd"

export (NodePath) var object_name
export (String) var function_name


func action() -> void:
	get_node(object_name).call(function_name)


func _ready() -> void:
	action = funcref(self, "action")
