extends Node2D

enum positions {BOTTOM, TOP}
export (positions) var init_pos = positions.BOTTOM

onready var computer = $Computer

func _ready():
	if init_pos == positions.TOP:
		var player = get_node(GLOBAL.player_path)
		player.position = computer.position + Vector2(0, 100)
