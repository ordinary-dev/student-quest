extends Control

# Animated text
# Usually used to display a date or time
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

# Delays
const DELAY_BEFORE_ANIMATION := 1.0
const DELAY_BETWEEN_LINES := 1.5
const DELAY_AFTER_ANIMATION := 1.5
# Delay per character
const DURATION := 0.05
# First line
export (String) var text_1
# Second line
export (bool) var show_second_line = true
export (String) var text_2
# Next scene
export (String, FILE, "*.tscn") var next_scene
export (bool) var fade_in = true
export (bool) var fade_out = true
export (float, 0.0, 5.0) var delay_before_next_scene = 0.0
# Scene objects
onready var _label1 := $BackgroundColor/Content/Line1
onready var _label2 := $BackgroundColor/Content/Line2
onready var _tween  := $Tween


# Prepare the scene
func _ready() -> void:
	if not show_second_line:
		_label2.visible = false
	_label1.percent_visible = 0
	_label2.percent_visible = 0
	_label1.text = text_1
	_label2.text = text_2
	_print_text()


func _print_text() -> void:
	yield(get_tree().create_timer(DELAY_BEFORE_ANIMATION), "timeout")
	# Print first line
	_print_line(_label1, text_1)
	if show_second_line:
		yield(get_tree().create_timer(DELAY_BETWEEN_LINES), "timeout")
		# Print second line
		_print_line(_label2, text_2)
	yield(get_tree().create_timer(DELAY_AFTER_ANIMATION), "timeout")
	_load_scene()


func _print_line(label: Label, text: String) -> void:
	_tween.interpolate_property(
		label, "percent_visible",
		0, 1, DURATION * len(text),
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT)
	_tween.start()
	# Wait for the animation to finish
	yield(get_tree().create_timer(
		DURATION * len(text)), "timeout")


func _load_scene() -> void:
	if delay_before_next_scene > 0:
		yield(get_tree().create_timer(delay_before_next_scene), "timeout")
	SCENES.load_scene(next_scene, fade_in, fade_out)
