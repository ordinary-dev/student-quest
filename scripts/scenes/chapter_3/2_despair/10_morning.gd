extends Node2D

export (String, FILE, "*.json") var dialog_path
export (String, FILE, "*.tscn") var scene_path


func activate_dialog() -> void:
	var player_path = STORAGE.get("player_path")
	assert(has_node(player_path))
	var player = get_node(player_path)
	player.lock()
	player.turn_left()
	DIALOG.show_dialog(dialog_path, get_path(), "load_scene")


func load_scene() -> void:
	SCENES.load_scene(scene_path, false, false)
