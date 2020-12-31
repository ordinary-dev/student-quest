tool
extends Node2D

# Character position adjustment
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

enum Positions {BOTTOM, TOP}
const Y_TOP_POSITION := -960
const Y_BOTTOM_POSITION := 900
const X_POSITION := 960
const PLAYER_PATH = "Player"
export (Positions) var initial_position = Positions.BOTTOM setget _set_position


func _set_position(val) -> void:
	initial_position = val
	if has_node(PLAYER_PATH):
		var player := get_node(PLAYER_PATH)
		match initial_position:
			Positions.TOP:
					player.position = Vector2(X_POSITION, Y_TOP_POSITION)
			Positions.BOTTOM:
					player.position = Vector2(X_POSITION, Y_BOTTOM_POSITION)
