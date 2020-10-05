extends Sprite

export (NodePath) var player_path
var player
var frame_num = 0

const anim_speed = 60
const distance = 500
const speed = 290

func _process(delta) -> void:
	if player.position.x - distance > position.x:
		position.x += speed * delta
		if frame_num < anim_speed:
			frame_num += 1
		else:
			frame_num = 0
			if frame == 5:
				frame = 2
			else:
				frame = 5
	else:
		frame = 8


func _ready():
	player = get_node(player_path)
	set_process(false)
