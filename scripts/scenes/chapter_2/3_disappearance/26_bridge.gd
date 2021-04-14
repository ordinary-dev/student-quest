extends Node2D

# Script for teleportation on the bridge
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const DIST := 600
export (String, FILE, "*.tscn") var scene_path
export (String, FILE, "*.json") var dialog_path
export (String, FILE, "*.json") var dialog_path_2
var _dialog_shown := false
var _player_path: String
var _player: KinematicBody2D
onready var _stranger := $Characters/Stranger
onready var _teleport_trigger   := $Teleports/TeleportTrigger
onready var _teleport_trigger_2 := $Teleports/TeleportTrigger2
onready var _teleport_trigger_3 := $Teleports/TeleportTrigger3


# The first function that will be called
# when approaching a stranger
func show_dialog() -> void:
	if not _dialog_shown:
		DIALOG.show_dialog(dialog_path, get_path(), "move")
		_dialog_shown = true


# This function will be called after the first dialog.
# It turns on the AI and the first trigger
func move() -> void:
	_stranger.set_process(true)
	_teleport_trigger.enabled = true


# The following function will be called
# when the player reaches the right end of the bridge
func teleport() -> void:
	# Disable AI
	_stranger.set_process(false)
	# Get path to player
	_player = get_node(STORAGE.get("player_path"))
	# Turn the player to the left
	_player.turn_left()
	# Move player and stranger
	_player.position.x -= DIST
	_stranger.position.x -= DIST
	# Wait for a little bit and show second dialog
	yield(get_tree().create_timer(1), "timeout")
	DIALOG.show_dialog(dialog_path_2, get_path(), "move_2")


# This function will be called after the second dialog.
# It turns on the AI and the second trigger
func move_2() -> void:
	_stranger.set_process(true)
	_teleport_trigger_2.enabled = true


# The second teleportation
func teleport_2() -> void:
	_player.turn_left()
	_player.position.x -= DIST
	_stranger.position.x -= DIST
	_teleport_trigger_3.enabled = true


# Load final scene of the chapter
func teleport_3() -> void:
	SCENES.load_scene(scene_path)
