# Exit confirmation script

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

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
