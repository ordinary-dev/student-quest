extends AnimatedSprite

# Script for water splashes
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

# Hide water splashes if this variable == 0 and show otherwise.
# Why isn't there something like 'var show_splashes := false'?
# This eliminates the problem when several
# colliders are standing side by side and
# the water splashes disappear.
var _number_of_requests := 0
# Bridges use this to prevent
# water splashes from showing
var hide_water := false setget _set_water_visibility


func enable_water() -> void:
	_number_of_requests += 1
	if !hide_water and _number_of_requests == 1:
		visible = true
		playing = true


func disable_water() -> void:
	_number_of_requests -= 1
	if _number_of_requests == 0:
		visible = false
		playing = false


func _set_water_visibility(val):
	hide_water = val
	if !hide_water:
		if _number_of_requests == 1:
			visible = true
			playing = true
	else:
		visible = false
		playing = false
