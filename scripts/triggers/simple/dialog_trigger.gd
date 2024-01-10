extends "res://scripts/triggers/simple/base.gd"

# Shows dialog without confirmation
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export_file("*.json") var dialog_path
@export var load_scene: bool = false
@export_file("*.tscn") var scene_path


func action() -> void:
	if load_scene:
		DIALOG.show_dialog(dialog_path, "/root/SCENES", "load_scene", scene_path)
	else:
		DIALOG.show_dialog(dialog_path)
