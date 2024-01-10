extends Node2D

@export_file("*.json") var dialog_path
@export_file("*.tscn") var scene_path


func activate_dialog() -> void:
	var player_path = STORAGE.get_value("player_path")
	assert(has_node(player_path))
	var player = get_node(player_path)
	false # player.lock() # TODOConverter3To4, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed
	player.turn_left()
	DIALOG.show_dialog(dialog_path, get_path(), "load_scene")


func load_scene() -> void:
	SCENES.load_scene(scene_path, false, false)
