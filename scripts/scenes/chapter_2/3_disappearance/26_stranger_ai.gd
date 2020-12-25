extends Sprite

# Simple AI for the scene on the bridge
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

const ANIM_SPEED = 50
const DISTANCE = 500
const SPEED = 290
export (NodePath) var player_path
var _player
var _frame_num = 0


func _process(delta) -> void:
	if _player.position.x - DISTANCE > position.x:
		position.x += SPEED * delta
		if _frame_num < ANIM_SPEED:
			_frame_num += 1
		else:
			_frame_num = 0
			# Animation of movement to the right
			if frame == 5:
				frame = 2
			else:
				frame = 5
	else:
		# Sprite without movement
		frame = 8


func _ready() -> void:
	set_process(false)
	_player = get_node(player_path)
