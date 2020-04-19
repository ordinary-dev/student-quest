extends Camera2D

# Camera shake

export (float) var max_diff = 3
# Offset every frame
export (float) var opf = 0.8
var pos : Vector2


func _process(_delta):
	var dif_x = rand_range(-opf, opf)
	var dif_y = rand_range(-opf, opf)
	
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
