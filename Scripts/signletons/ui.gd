extends CanvasLayer

# API for user interface
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

export (bool) var show_pause_menu setget _show_pause_menu
export (bool) var show_joystick setget _show_joystick
# Show joystick on win/mac/linux for debugging
export (bool) var force_joystick = false
onready var _joystick = $"Joystick-UI"
onready var _pause_menu = $"PauseMenu-UI"


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
