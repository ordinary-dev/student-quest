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
@export var text_1: String
# Second line
@export var show_second_line: bool = true
@export var text_2: String
# Next scene
@export_file("*.tscn") var next_scene
@export var fade_in: bool = true
@export var fade_out: bool = true
@export_range(0.0, 5.0) var delay_before_next_scene: float = 0.0
# Scene objects
@onready var _label1 := $BackgroundColor/Content/Line1
@onready var _label2 := $BackgroundColor/Content/Line2


# Prepare the scene
func _ready() -> void:
	if not show_second_line:
		_label2.visible = false
	_label1.visible_ratio = 0.0
	_label2.visible_ratio = 0.0
	_label1.text = text_1
	_label2.text = text_2
	_print_text()


func _print_text() -> void:
	await get_tree().create_timer(DELAY_BEFORE_ANIMATION).timeout
	# Print first line
	_print_line(_label1, text_1)
	if show_second_line:
		await get_tree().create_timer(DELAY_BETWEEN_LINES).timeout
		# Print second line
		_print_line(_label2, text_2)
	await get_tree().create_timer(DELAY_AFTER_ANIMATION).timeout
	_load_scene()


func _print_line(label: Label, text: String) -> void:
	label.visible_ratio = 1.0
	# Wait for the animation to finish
	await get_tree().create_timer(DURATION * len(text)).timeout


func _load_scene() -> void:
	if delay_before_next_scene > 0:
		await get_tree().create_timer(delay_before_next_scene).timeout
	SCENES.load_scene(next_scene, fade_in, fade_out)
