# Script for an alternative start of the game

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Control

export (String, FILE, "*.json") var dialog_path
export (String, FILE, "*.txt")  var text_file_path
export (String, FILE, "*.tscn") var menu_scene_path

onready var console := $MarginContainer/Console
onready var beeps := $Beeps
onready var tv := $Tv

const delay_before_printing := 0.8
const delay_before_result   := 0.2
const delay_after_result    := 0.1
const delay_after_printing  := 0.7


func _ready() -> void:
	# Dialog
	DIALOG.show_dialog(dialog_path, get_path(), "print_to_console")


func print_to_console() -> void:
	# Play button and beeps sound
	FX.btn_click()
	beeps.play()
	# Delay before printing
	yield(get_tree().create_timer(delay_before_printing), "timeout")
	# Print file contents to console
	var text_file = File.new()
	text_file.open(text_file_path, File.READ)
	# Print first five lines
	for _i in range(5):
		# Print text
		var buf : String = text_file.get_line()
		console.text += buf
		# Print result
		yield(get_tree().create_timer(delay_before_result), "timeout")
		console.text += "[ok]\n"
		yield(get_tree().create_timer(delay_after_result), "timeout")
	# Print last line
	var buf : String = text_file.get_line()
	console.text += buf
	yield(get_tree().create_timer(delay_after_printing), "timeout")
	tv.play()
	# Close file
	text_file.close()
	# Load scene
	SCENES.load_scene(menu_scene_path)
