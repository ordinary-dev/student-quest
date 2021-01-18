extends "res://scripts/triggers/advanced/base.gd"

# Shows dialog after confirmation
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.json") var dialog_path
export (bool) var load_scene = false
export (String, FILE, "*.tscn") var scene_path


func action() -> void:
	if load_scene:
		DIALOG.show_dialog(dialog_path, "/root/SCENES", "load_scene", scene_path)
	else:
		DIALOG.show_dialog(dialog_path)
