# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends CanvasLayer

export (bool) var show_joystick setget change_joystick_state
# Show joystick on win/mac/linux for debugging
export (bool) var force_joystick = false

export (bool) var show_pause_menu setget change_pause_menu_state

onready var joystick = $"Joystick-UI"
onready var pause_menu = $"PauseMenu-UI"


func change_joystick_state(var value : bool) -> void:
	if show_joystick != value:
		if value:
			if (OS.get_name() == "Android" or force_joystick):
				joystick.visible = true
		else:
			joystick.visible = false
	show_joystick = value


func change_pause_menu_state(var value : bool) -> void:
	if show_pause_menu != value:
		if value:
			pause_menu.visible = true
		else:
			pause_menu.visible = false
	show_pause_menu = value
