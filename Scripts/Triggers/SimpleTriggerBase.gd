# Simple trigger base class

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Area2D

export (bool) var activate_once = false

var action : FuncRef
var used := false


func _on_body_entered(_body):
	if (activate_once and not used) or (activate_once == false):
		action.call_func()
		used = true
