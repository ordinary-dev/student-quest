extends Node2D

# Turns off the light without animation
# and loads the scene

export (String, FILE, "*.tscn") var scene_path
onready var _background := $Background


func _ready() -> void:
	yield(get_tree().create_timer(1), "timeout")
	_background.color = Color("#1c1c1c")
	yield(get_tree().create_timer(1), "timeout")
	SCENES.load_scene(scene_path)
