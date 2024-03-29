extends Control

# Script for an alternative start of the game
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const DELAY_BEFORE_PRINTING := 0.8
const DELAY_BEFORE_RESULT   := 0.2
const DELAY_AFTER_RESULT    := 0.1
const DELAY_AFTER_PRINTING  := 0.7
# Dialog at the beginning of the scene
@export_file("*.json") var dialog_path
# File with text to be printed in the console
@export_file("*.txt")  var text_file_path
# Next scene
@export_file("*.tscn") var menu_scene_path
# Label
@onready var _console := $MarginContainer/Console
# Sounds
@onready var _beeps := $Beeps
@onready var _tv_sound := $Tv


func print_to_console() -> void:
	# Play button and beeps sound
	FX.play_btn_click()
	_beeps.play()
	# Delay before printing
	await get_tree().create_timer(DELAY_BEFORE_PRINTING).timeout
	# Print file contents to console
	var text_file = FileAccess.open(text_file_path, FileAccess.READ)
	assert(text_file != null)
	# Print first five lines
	for _i in range(5):
		# Print text
		var buf: String = text_file.get_line()
		_console.text += buf
		# Print result
		await get_tree().create_timer(DELAY_BEFORE_RESULT).timeout
		_console.text += "[ok]\n"
		await get_tree().create_timer(DELAY_AFTER_RESULT).timeout
	# Print last line
	var buf: String = text_file.get_line()
	_console.text += buf
	await get_tree().create_timer(DELAY_AFTER_PRINTING).timeout
	_tv_sound.play()
	# Close file
	text_file.close()
	# Load scene
	SCENES.load_scene(menu_scene_path)


func _ready() -> void:
	DIALOG.show_dialog(dialog_path, get_path(), "print_to_console")
