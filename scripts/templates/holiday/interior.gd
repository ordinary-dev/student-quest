tool
extends Node2D

# Controls the state of the door.
# Loads the next scene.
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const TRIGGER_PATH := "Trigger"
export (bool) var door_open = true setget _set_door_status
export (String, FILE, "*.tscn") var street_scene
onready var _street_trigger := $Trigger


func street() -> void:
	SCENES.load_scene(street_scene)


func _set_door_status(val: bool) -> void:
	door_open = val
	# Hide trigger in editor if door is locked
	if Engine.editor_hint:
		if has_node(TRIGGER_PATH):
			var trigger = get_node(TRIGGER_PATH)
			trigger.visible = door_open
	# Destroy trigger if door is locked
	# But not in editor mode
	elif not door_open:
		_street_trigger.queue_free()
