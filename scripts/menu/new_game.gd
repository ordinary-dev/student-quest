extends Control

# New game script
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.tscn") var menu
export (String, FILE, "*.tscn") var next_scene


func _start_game() -> void:
	FX.play_btn_click()
	SCENES.load_scene(next_scene)


func _on_Return_pressed() -> void:
	FX.play_btn_click()
	SCENES.load_scene(menu)
