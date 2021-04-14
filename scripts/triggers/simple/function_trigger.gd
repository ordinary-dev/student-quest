extends "res://scripts/triggers/simple/base.gd"

# Calls a function without confirmation
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

export (bool) var enabled = true
export (bool) var call_one_time = false
export (NodePath) var obj
export (String) var method
var _called = false


func action() -> void:
	if enabled:
		if (call_one_time and not _called) or (not call_one_time):
			get_node(obj).call_deferred(method)
			_called = true
