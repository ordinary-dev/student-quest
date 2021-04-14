extends Control

# Script for choosing the ending
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.tscn") var edit_scene_path
export (String, FILE, "*.tscn") var delete_scene_path


func _on_Edit_pressed() -> void:
	FX.play_btn_click()
	SCENES.load_scene(edit_scene_path)


func _on_Delete_pressed() -> void:
	FX.play_btn_click()
	SCENES.load_scene(delete_scene_path)
