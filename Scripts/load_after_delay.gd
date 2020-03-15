extends Node

# Шаблон для загрузки сцены через некоторое время

export (String, FILE, "*.tscn") var next_scene
export (float, 0.0, 5.0) var delay = 0.0
export (bool) var transition_in = true
export (bool) var transition_out = true

func _ready():
	yield(get_tree().create_timer(delay), "timeout")
	get_node("/root/scene_loader").load_scene(
		next_scene, transition_in, transition_out)
