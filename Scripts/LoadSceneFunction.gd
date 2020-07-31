extends Node2D

# Template for triggers

export (String, FILE, "*.tscn") var scene_path 


func load_scene() -> void:
	SCENES.load_scene(scene_path)
