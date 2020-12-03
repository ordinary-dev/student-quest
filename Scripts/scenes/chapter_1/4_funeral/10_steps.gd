extends Node2D

# Loads an additional scene
# for the first time, then skips it
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.tscn") var dialog_scene
export (String, FILE, "*.tscn") var basement_scene


func go() -> void:
	if STORAGE.is_saved("basement_visited"):
		SCENES.load_scene(basement_scene)
	else:
		STORAGE.save("basement_visited", true)
		SCENES.load_scene(dialog_scene)
