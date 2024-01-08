extends Area2D

# Makes an object semi-transparent
# when the player approaches it
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

# New color
const MOD_COLOR := Color(1, 1, 1, 0.3)
# Animation duration
const TIME := 0.3
@export_node_path var object
# Loaded object
var _obj
# Standart color
var _def_color := Color(1, 1, 1, 1)
@onready var _tween := $Tween


# Remember color
func _ready() -> void:
	_obj = get_node(object)
	_def_color = _obj.modulate


# Make object transparent
func _on_Area2D_body_entered(_body) -> void:
	var tween = create_tween()
	tween.tween_property(_obj, "modulate", MOD_COLOR, TIME).from(_obj.modulate)


# Return default color
func _on_Area2D_body_exited(_body) -> void:
	var tween = create_tween()
	tween.tween_property(_obj, "modulate", _def_color, TIME).from(_obj.modulate)
