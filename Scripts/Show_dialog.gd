extends Node


export (String, FILE, "*.json") var dialog_path

export (bool) var enable_delay = false
export (float) var delay = 2.0

export (bool) var load_scene = false
export (String, FILE, "*.tscn") var scene_path
export (float) var loading_delay = 0.0

export (bool) var call_function = false
export (NodePath) var object_path
export (String) var method


func load_next_scene() -> void:
	if loading_delay > 0:
		yield(get_tree().create_timer(loading_delay), "timeout")
	SCENES.load_scene(scene_path)


func fncall() -> void:
	get_node(object_path).call(method)


func _ready() -> void:
	if enable_delay:
		yield(get_tree().create_timer(delay), "timeout")
	if load_scene:
		DIALOG.show_dialog(dialog_path, get_path(), "load_next_scene")
	elif call_function:
		DIALOG.show_dialog(dialog_path, get_path(), "fncall")
	else:
		DIALOG.show_dialog(dialog_path)
