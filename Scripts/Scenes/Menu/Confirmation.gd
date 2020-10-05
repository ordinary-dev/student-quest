# Exit confirmation script

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Control

export (String, FILE, "*.tscn") var quit_scene_path


# Return to menu
func _return() -> void:
	FX.btn_click()
	# Hide scene
	visible = false


# Quit the game
func _quit() -> void:
	FX.btn_click()
	SCENES.load_scene(quit_scene_path)
