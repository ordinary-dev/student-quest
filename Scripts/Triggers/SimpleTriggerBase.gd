# Simple trigger base class

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Area2D

var action : FuncRef


func _on_body_entered(_body):
	action.call_func()
