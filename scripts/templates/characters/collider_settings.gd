extends Sprite2D

@export var enable_collider: bool = true: set = _col


func _col(val: bool) -> void:
	enable_collider = val
	$StaticBody2D/CollisionShape2D.disabled = !enable_collider
