extends "res://scripts/triggers/advanced/base.gd"

# Calls a function after confirmation
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

export (NodePath) var object_name
export (String) var function_name


func action() -> void:
	get_node(object_name).call(function_name)
