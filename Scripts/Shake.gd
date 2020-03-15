extends Camera2D

# Тряска камеры. 
# Выбирает для каждой оси случайное значение между
# -dpf и dpf, а затем прибавляет его к координатам.
# Новые координаты по каждой оси
# не будут отличаться от оригинальных больше,
# чем на max_diff

export (float) var max_diff = 3
# Difference per frame
export (float) var dpf = 0.8
var pos : Vector2


func _process(_delta):
	var dif_x = rand_range(-dpf, dpf)
	var dif_y = rand_range(-dpf, dpf)
	
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
	
