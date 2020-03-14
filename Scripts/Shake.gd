extends Sprite

export (float) var max_diff = 3
export (float) var rand_val = 0.15
var pos : Vector2
var mult :float = 0

func _process(delta):
	if mult < 2:
		mult += 0.05
	else:
		mult = 0
	var rr = rand_val * mult
	var dif_x = rand_range(-rr, rr)
	var dif_y = rand_range(-rr, rr)
	if dif_x >= 0:
		if pos.x + max_diff > position.x + dif_x:
			position.x += dif_x
	else:
		if pos.x - max_diff < position.x + dif_x:
			position.x += dif_x
	if dif_y >= 0:
		if pos.y + max_diff > position.y + dif_y:
			position.y += dif_y
	else:
		if pos.y - max_diff < position.y + dif_y:
			position.y += dif_y
	

func _ready():
	pos = position
	
