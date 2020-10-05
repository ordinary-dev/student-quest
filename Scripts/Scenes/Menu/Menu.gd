# Menu interface script

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Control

# Path to the scene with new game
export (String, FILE, "*.tscn") var new_game_scene

export (NodePath) var game_loading_scene_path
export (NodePath) var settings_scene_path
export (NodePath) var confirmation_scene_path

export (NodePath) var new_game_btn

var game_loading_scene
var settings_scene
var confirmation_scene


# Create new game
func _new_game() -> void:
	FX.btn_click()
	GLOBAL.write_settings()
	SCENES.load_scene(new_game_scene)


# Show saved games
func _load_game() -> void:
	FX.btn_click()
	game_loading_scene.visible = !game_loading_scene.visible
	settings_scene.visible = false
	confirmation_scene.visible = false


# Show or hide settings
func _settings() -> void:
	FX.btn_click()
	settings_scene.visible = !settings_scene.visible
	game_loading_scene.visible = false
	confirmation_scene.visible = false


# Confirmation
func _quit() -> void:
	FX.btn_click()
	confirmation_scene.visible = !confirmation_scene.visible
	game_loading_scene.visible = false
	settings_scene.visible = false


func _ready() -> void:
	# Get nodes
	game_loading_scene = get_node(game_loading_scene_path)
	settings_scene = get_node(settings_scene_path)
	confirmation_scene = get_node(confirmation_scene_path)
	# Disable scenes
	game_loading_scene.visible = false
	settings_scene.visible = false
	confirmation_scene.visible = false
	# Focus
	get_node(new_game_btn).grab_focus()
