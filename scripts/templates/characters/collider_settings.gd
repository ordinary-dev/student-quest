extends Sprite

export (bool) var enable_collider = true setget _col


func _col(val: bool) -> void:
	enable_collider = val
	$StaticBody2D/CollisionShape2D.disabled = !enable_collider
