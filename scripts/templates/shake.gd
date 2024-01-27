extends Camera2D

# Camera shake

@export var max_diff: float = 3
# Offset every frame
@export var opf: float = 0.8
var _pos: Vector2


func _process(_delta: float) -> void:
	var dif_x = randf_range(-opf, opf)
	var dif_y = randf_range(-opf, opf)
	
	if dif_x >= 0:
		if _pos.x + max_diff > position.x + dif_x:
			position.x += dif_x
	else:
		if _pos.x - max_diff < position.x + dif_x:
			position.x += dif_x
	
	if dif_y >= 0:
		if _pos.y + max_diff > position.y + dif_y:
			position.y += dif_y
	else:
		if _pos.y - max_diff < position.y + dif_y:
			position.y += dif_y


func _ready() -> void:
	_pos = position
