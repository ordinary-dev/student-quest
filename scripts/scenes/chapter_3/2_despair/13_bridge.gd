extends Node2D

# Turns on the AI and blocks the player

@onready var _neo = $Neo
@onready var _player = $Body


func start_sequence() -> void:
	_player.turn_left()
	false # _player.lock() # TODOConverter3To4, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed
	_neo.enable_ai()
