# Animated text

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Control


# First line
export (String) var text_1
# Second line
export (bool) var show_second_line = true
export (String) var text_2
export (String, FILE, "*.tscn") var next_scene
export (bool) var fade_in = true
export (bool) var fade_out = true

# Delays
const delay_before_animation = 1.0
const delay_between = 0.5
const delay_after_animation = 1.5
# Delay per character
const duration = 0.05

export (float, 0.0, 5.0) var delay_before_next_scene = 0.0


# Scene objects
onready var label1 = $BackgroundColor/Content/Line1
onready var label2 = $BackgroundColor/Content/Line2
onready var tween  = $Tween


func _ready() -> void:
	if not show_second_line:
		label2.visible = false
	label1.percent_visible = 0
	label2.percent_visible = 0
	label1.text = text_1
	label2.text = text_2
	print_text()


func print_text() -> void:
	# Delay before animation
	yield(get_tree().create_timer(delay_before_animation), "timeout")
	# Print first line
	tween.interpolate_property(
		label1, "percent_visible",
		0, 1, duration * len(text_1),
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	tween.start()
	# Delay
	yield(get_tree().create_timer(
		duration * len(text_1) + delay_between), 
		"timeout"
	)
	if show_second_line:
		yield(get_tree().create_timer(delay_between), "timeout")
		# Print second line
		tween.interpolate_property(
			label2, "percent_visible",
			0, 1, duration * len(text_2),
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
		)
		tween.start()
		yield(get_tree().create_timer(
			duration * len(text_2)), 
			"timeout"
		)
	yield(get_tree().create_timer(delay_after_animation), "timeout")
	load_scene()


func load_scene() -> void:
	if delay_before_next_scene > 0:
		yield(get_tree().create_timer(delay_before_next_scene), "timeout")
	SCENES.load_scene(next_scene, fade_in, fade_out)
