# Script to open links in browser

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node

export (String, FILE, "*.tscn") var credits_scene


func open_site(link : String) -> void:
	var err = OS.shell_open(link)
	if err != OK:
		print("Can't open link!")


func open_store() -> void:
	open_site("https://pixeltrain.itch.io/student-quest")


func open_patreon() -> void:
	open_site("https://www.patreon.com/pixeltrain")


func open_ko_fi() -> void:
	open_site("https://ko-fi.com/pixeltrain")


func open_liberapay() -> void:
	open_site("https://liberapay.com/pixeltrain")


func open_credits() -> void:
	SCENES.load_scene(credits_scene)
