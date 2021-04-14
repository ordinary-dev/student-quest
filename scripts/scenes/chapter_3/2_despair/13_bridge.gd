extends Node2D

# Turns on the AI and blocks the player

onready var _neo = $Neo
onready var _player = $Body


func start_sequence() -> void:
	_player.turn_left()
	_player.lock()
	_neo.enable_ai()
