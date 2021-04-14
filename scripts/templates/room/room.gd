extends Node2D

# Script for a scene with a room.
# It controls the character.
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

enum Positions {DOOR, COMPUTER, BED}
export (bool) var character_enabled = true
export (Positions) var init_pos = Positions.DOOR
onready var _door_marker := $Positions/Door
onready var _comp_marker := $Positions/Computer
onready var _bed_marker := $Positions/Bed


func _ready() -> void:
	var player_path = STORAGE.get("player_path")
	var player = get_node(player_path)
	if !character_enabled:
		player.queue_free()
	else:
		match init_pos:
			Positions.DOOR:
				player.position = _door_marker.position
			Positions.COMPUTER:
				player.position = _comp_marker.position
			Positions.BED:
				player.position = _bed_marker.position
	
