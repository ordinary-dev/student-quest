extends CanvasLayer

# API for user interface
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export var show_pause_menu : bool : set = _show_pause_menu
@export var show_joystick : bool : set = _show_joystick
# Show joystick on win/mac/linux for debugging
@export var force_joystick = false
@onready var _joystick = $Joystick
@onready var _pause_menu = $"PauseMenu-UI"


func _show_joystick(value: bool) -> void:
	if show_joystick != value:
		show_joystick = value
		if show_joystick:
			if OS.get_name() == "Android" or force_joystick:
				_joystick.visible = true
		else:
			_joystick.visible = false


func _show_pause_menu(value: bool) -> void:
	if show_pause_menu != value:
		show_pause_menu = value
		_pause_menu.visible = show_pause_menu
