tool
extends Node2D

# Manages settings and loading
# of scenes in the forest
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

enum Locations {House, Campfire}

const NEO_PATH := "YSort/Neo"
const CAMPFIRE_PATH := "YSort/Campfire"

export (bool) var main_door_open = true
export (bool) var another_door_open = false
export (Locations) var initial_location = Locations.House
export (String, FILE, "*.tscn") var interior_scene
export (String, FILE, "*.tscn") var small_house
export (bool) var show_neo = true setget _set_neo_visibility
export (bool) var show_campfire = true setget _set_campfire_visibility

onready var _trigger = $MainHouseTrigger


func open_door() -> void:
	if another_door_open:
		SCENES.load_scene(small_house)
	else:
		yield(get_tree().create_timer(0.3), "timeout")
		NOTIFY.show("NO_KEY")


func house() -> void:
	SCENES.load_scene(interior_scene)


func _set_neo_visibility(val: bool) -> void:
	show_neo = val
	if has_node(NEO_PATH):
		var neo = get_node(NEO_PATH)
		neo.visible = show_neo
		neo.enable_collider = show_neo


func _set_campfire_visibility(val: bool) -> void:
	show_campfire = val
	if has_node(CAMPFIRE_PATH):
		var campfire = get_node(CAMPFIRE_PATH)
		campfire.enabled = show_campfire


func _ready() -> void:
	if not main_door_open:
		_trigger.queue_free()
	if initial_location == Locations.Campfire:
		var player_path = STORAGE.get("player_path")
		get_node(player_path).position = get_node(CAMPFIRE_PATH).position - Vector2(100, 100)
