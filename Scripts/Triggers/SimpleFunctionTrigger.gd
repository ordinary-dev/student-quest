# Function trigger

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends "res://Scripts/Triggers/SimpleTriggerBase.gd"

export (bool) var enabled = true
export (bool) var call_one_time = false
export (NodePath) var obj
export (String) var method
var called = false


func action() -> void:
	if enabled:
		if call_one_time and not called or not call_one_time:
			get_node(obj).call_deferred(method)
			called = true


func _ready() -> void:
	action = funcref(self, "action")
