extends Node
class_name DialogLoader

# Shows dialog at scene start
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.json") var dialog_path

export (bool) var enable_delay = false
export (float) var delay = 2.0

export (bool) var load_scene = false
export (String, FILE, "*.tscn") var scene_path
export (float) var loading_delay = 0.0
export (bool) var fade_in = true
export (bool) var fade_out = true

export (bool) var show_once = false
export (String) var uid = "id"

export (bool) var call_function = false
export (NodePath) var obj
export (String) var fun


func load_next_scene() -> void:
	if loading_delay > 0:
		yield(get_tree().create_timer(loading_delay), "timeout")
	SCENES.load_scene(scene_path, fade_in, fade_out)


func _ready() -> void:
	if enable_delay:
		yield(get_tree().create_timer(delay), "timeout")
	if show_once:
		if not STORAGE.is_saved(uid):
			STORAGE.save(uid, true)
			_show_dialog()
	else:
		_show_dialog()


func _show_dialog() -> void:
	if load_scene:
		DIALOG.show_dialog(dialog_path, get_path(), "load_next_scene")
	elif call_function:
		DIALOG.show_dialog(dialog_path, get_node(obj).get_path() , fun)
	else:
		DIALOG.show_dialog(dialog_path)
