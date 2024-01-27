extends Node2D

@export_file("*.tscn") var room_scene
@export_file("*.tscn") var basement_scene


func room() -> void:
	SCENES.load_scene(room_scene)


func go_down() -> void:
	SCENES.load_scene(basement_scene)
