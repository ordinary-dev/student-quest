extends Node2D

export (Resource) var next_scene

func _ready():
	get_node("Particles2D").emitting = true
	yield(get_tree().create_timer(0.5), "timeout")
	get_node("Particles2D2").emitting = true
	yield(get_tree().create_timer(0.25),"timeout")
	get_node("Particles2D3").emitting = true
	yield(get_tree().create_timer(4),"timeout")
	get_tree().get_root().get_node("RootNode").call("load_scene_additive", next_scene.resource_path)