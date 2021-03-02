extends Node

onready var _joystick := $"/root/UI/Joystick/TapButton"


func get_joystick_input() -> Vector2:
	return _joystick.get_value()
