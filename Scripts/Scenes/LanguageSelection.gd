# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Control

export (String, FILE, "*.tscn") var next_scene


func load_scene() -> void:
	SCENES.load_scene(next_scene)


func set_ru() -> void:
	TranslationServer.set_locale("ru")
	load_scene()


func set_en() -> void:
	TranslationServer.set_locale("en")
	load_scene()
