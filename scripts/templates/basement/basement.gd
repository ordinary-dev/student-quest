@tool
extends Node2D

# Script for quick setup of the basement
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

# I haven't found a better way
# to store paths to objects
const NEO_PATH := "Node2D/Neo"
const LIGHT_PATH := "PointLight2D"
const COMPUTER_PATH := "Computer"
@export (bool) var show_neo = false: set = _set_neo_visibility
@export (bool) var enable_light = true: set = _set_light_visibility
@export (bool) var show_computer = true: set = _set_computer_visibility


func _set_neo_visibility(val: bool) -> void:
	show_neo = val
	if has_node(NEO_PATH):
		var neo := get_node(NEO_PATH)
		neo.visible = show_neo
		neo.enable_collider = show_neo


func _set_light_visibility(val: bool) -> void:
	enable_light = val
	if has_node(LIGHT_PATH):
		var light := get_node(LIGHT_PATH)
		light.enabled = enable_light


func _set_computer_visibility(val: bool) -> void:
	show_computer = val
	if has_node(COMPUTER_PATH):
		var comp := get_node(COMPUTER_PATH)
		comp.visible = show_computer
