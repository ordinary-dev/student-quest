extends Node

# Script for the information panel in the menu.
# Opens links in the browser
# and loads the scene with captions.
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.tscn") var credits_scene

onready var version_label = $Scroll/MarginContainer/TextContainer/Version


func open_store() -> void:
	_open_site("https://pixeltrain.itch.io/student-quest")


func open_patreon() -> void:
	_open_site("https://www.patreon.com/pixeltrain")


func open_ko_fi() -> void:
	_open_site("https://ko-fi.com/pixeltrain")


func open_liberapay() -> void:
	_open_site("https://liberapay.com/pixeltrain")


func open_credits() -> void:
	SCENES.load_scene(credits_scene)


func _open_site(link: String) -> void:
	var err := OS.shell_open(link)
	if err != OK:
		NOTIFY.show("Can't open link")


func _ready() -> void:
	# Read version from file
	var fp := File.new()
	var status := fp.open("res://VERSION.txt", File.READ)
	assert(status == OK)
	var version := "v" + fp.get_as_text()
	version_label.text = version
