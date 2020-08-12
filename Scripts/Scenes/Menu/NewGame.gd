# New game script

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Control

export (String, FILE, "*.tscn") var menu
export (String, FILE, "*.tscn") var next_scene


func _start_game():
	FX.btn_click()
	SCENES.load_scene(next_scene)


func _on_Return_pressed():
	FX.btn_click()
	SCENES.load_scene(menu)
