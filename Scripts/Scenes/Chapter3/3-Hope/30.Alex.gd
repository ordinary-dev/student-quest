extends Sprite

var time := 0.0
const delay := 60.0

func _process(delta) -> void:
	time += delta * 60
	if time > delay:
		time = 0
		if frame == 0:
			frame = 3
		else:
			frame = 0
