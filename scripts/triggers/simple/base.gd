extends Area2D

# Simple trigger base class
# All inherited classes must override the "action" method!
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export var activate_once: bool = false
var _used := false


# Do not forget to override this method
func action() -> void:
	pass


func _on_body_entered(_body):
	if (activate_once and not _used) or (activate_once == false):
		action()
		_used = true
