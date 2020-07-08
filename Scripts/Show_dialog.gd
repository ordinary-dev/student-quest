extends Node


export (String, FILE, "*.json") var dialog_path
export (bool) var enable_delay = false
export (float) var delay = 2.0
export (bool) var load_scene = false
export (String, FILE, "*.tscn") var scene_path


func load_next_scene() -> void:
	SCENES.load_scene(scene_path)


func _ready() -> void:
	if enable_delay:
		yield(get_tree().create_timer(delay), "timeout")
	if load_scene:
		DIALOG.show_dialog(dialog_path, get_path(), "load_next_scene")
	else:
		DIALOG.show_dialog(dialog_path)
