extends Control

# Script for selecting the language
# and loading the next scene
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export_file("*.tscn") var next_scene


func set_ru() -> void:
	TranslationServer.set_locale("ru")
	_load_scene()


func set_en() -> void:
	TranslationServer.set_locale("en")
	_load_scene()


func _load_scene() -> void:
	SCENES.load_scene(next_scene)
