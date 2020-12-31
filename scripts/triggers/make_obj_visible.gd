extends Area2D

# Trigger that changes
# the visibility of an object

export (NodePath) var object


func _on_Area2D_body_entered(_body) -> void:
	get_node(object).visible = true


func _on_Area2D_body_exited(_body) -> void:
	get_node(object).visible = false


func _ready() -> void:
	get_node(object).visible = false
