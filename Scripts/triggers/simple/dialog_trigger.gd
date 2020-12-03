extends "res://Scripts/triggers/simple/base.gd"

# Shows dialog without confirmation
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.json") var dialog_path
export (bool) var load_scene = false
export (String, FILE, "*.tscn") var scene_path


func action() -> void:
	if load_scene:
		DIALOG.show_dialog(dialog_path, "/root/SCENES", "load_scene", scene_path)
	else:
		DIALOG.show_dialog(dialog_path)
