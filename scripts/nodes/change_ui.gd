extends Node
class_name ChangeUI

# Allows you to change the visibility 
# of elements at the start of the scene
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export var show_pause_menu: bool = false
@export var show_joystick: bool = false


func _ready() -> void:
	UI.show_joystick = show_joystick
	UI.show_pause_menu = show_pause_menu
