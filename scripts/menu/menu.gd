extends Control

# Menu interface script
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

# Path to the scene with new game
export (String, FILE, "*.tscn") var new_game_scene
# The button that gets the focus
onready var new_game_btn := $Left/Column/NewGame
# Menu sections
onready var game_loading_scene := $Right/LoadMenu
onready var settings_scene := $Right/Settings
onready var confirmation_scene := $Right/Confirmation


# Start new game
func _new_game() -> void:
	FX.play_btn_click()
	SETTINGS.write_settings()
	SCENES.load_scene(new_game_scene)


# Show the list of chapters
func _load_game() -> void:
	FX.play_btn_click()
	game_loading_scene.visible = !game_loading_scene.visible
	settings_scene.visible = false
	confirmation_scene.visible = false


# Show or hide settings
func _settings() -> void:
	FX.play_btn_click()
	settings_scene.visible = !settings_scene.visible
	game_loading_scene.visible = false
	confirmation_scene.visible = false


# Confirmation
func _quit() -> void:
	FX.play_btn_click()
	confirmation_scene.visible = !confirmation_scene.visible
	game_loading_scene.visible = false
	settings_scene.visible = false


func _ready() -> void:
	# Disable scenes
	game_loading_scene.visible = false
	settings_scene.visible = false
	confirmation_scene.visible = false
	# Focus
	new_game_btn.grab_focus()
