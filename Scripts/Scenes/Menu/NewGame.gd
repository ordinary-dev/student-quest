# New game script

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Control

export (String, FILE, "*.tscn") var menu
export (String, FILE, "*.tscn") var next_scene


func _start_game():
	FX.btn_click()
	SCENES.load_scene(next_scene)


func _on_Return_pressed():
	FX.btn_click()
	SCENES.load_scene(menu)
