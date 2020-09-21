# Stairs

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node2D

export (String, FILE, "*.tscn") var dialog
export (String, FILE, "*.tscn") var secret


func go() -> void:
	if TEMP.is_saved("stairs_secret"):
		SCENES.load_scene(secret)
	else:
		TEMP.save("stairs_secret", true)
		SCENES.load_scene(dialog)
