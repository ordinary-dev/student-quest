extends Control

# The script for exit confirmation
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.tscn") var quit_scene_path


# Return to menu
func _return() -> void:
	FX.play_btn_click()
	visible = false


# Quit the game
func _quit() -> void:
	FX.play_btn_click()
	SCENES.load_scene(quit_scene_path)
