extends Node
class_name DialogLoader

# Shows dialog at scene start
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export_file("*.json") var dialog_path

@export var enable_delay: bool = false
@export var delay: float = 2.0

@export var load_scene: bool = false
@export_file ("*.tscn") var scene_path
@export var loading_delay: float = 0.0
@export var fade_in: bool = true
@export var fade_out: bool = true

@export var show_once: bool = false
@export var uid: String = "id"

@export var call_function: bool = false
@export var obj: NodePath
@export var fun: String


func load_next_scene() -> void:
	if loading_delay > 0:
		await get_tree().create_timer(loading_delay).timeout
	SCENES.load_scene(scene_path, fade_in, fade_out)


func _ready() -> void:
	if enable_delay:
		await get_tree().create_timer(delay).timeout
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
