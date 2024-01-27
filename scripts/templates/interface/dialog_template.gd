extends Control

# Dialog template
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

# Offsets
const LEFT_OFFSET_START := 100
const LEFT_OFFSET_END := 50
const RIGHT_OFFSET_START := 1770
const RIGHT_OFFSET_END := 1870
# Animation duration
const ANIM_DURATION := 0.1
const TEXT_ANIM_SPEED := 60.0

var _first_time := true

# For other scripts
@onready var next_button := $Button
# Animated objects
@onready var _border := $MarginContainer/Border
@onready var _body := $MarginContainer/Body
# Labels
@onready var _name_label := $MarginContainer/Body/Margin/Labels/Name
@onready var _text_label := $MarginContainer/Body/Margin/Labels/Text


# Show the dialog on the screen
func play_dialog(character_name: String, text: String) -> void:
	_name_label.text = character_name
	_text_label.visible_ratio = 0.0
	_text_label.text = text
	if _first_time:
		_play(true)
		_first_time = false
	else:
		_play(false)


# Destroy this object
func hide_dialog() -> void:
	anim_template(LEFT_OFFSET_END, LEFT_OFFSET_START, 
			RIGHT_OFFSET_END, RIGHT_OFFSET_START, 
			true, false)
	await get_tree().create_timer(ANIM_DURATION).timeout
	queue_free()


# Appearance animation
func _play(play_anim: bool):
	anim_template(LEFT_OFFSET_START, LEFT_OFFSET_END, 
			RIGHT_OFFSET_START, RIGHT_OFFSET_END, play_anim)


# Animation
func anim_template(left_from: int, left_to: int, 
			right_from: int, right_to: int, 
			animate_form: bool, text_anim := true) -> void:
	if animate_form:
		for obj in [_border, _body]:
			obj.offset_left = left_to
			obj.offset_right = right_to
		if text_anim:
			await get_tree().create_timer(ANIM_DURATION).timeout
	if text_anim:
		_text_label.visible_ratio = 1.0
