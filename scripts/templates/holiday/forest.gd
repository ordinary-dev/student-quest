@tool
extends Node2D

# Manages settings and loading
# of scenes in the forest
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

enum Locations {House, Campfire}

const NEO_PATH := "Node2D/Neo"
const CAMPFIRE_PATH := "Node2D/Campfire"

@export var main_door_open: bool = true
@export var another_door_open: bool = false
@export var initial_location: Locations = Locations.House
@export_file("*.tscn") var interior_scene
@export_file("*.tscn") var small_house
@export var show_neo: bool = true: set = _set_neo_visibility
@export var show_campfire: bool = true: set = _set_campfire_visibility

@onready var _trigger = $MainHouseTrigger


func open_door() -> void:
	if another_door_open:
		SCENES.load_scene(small_house)
	else:
		await get_tree().create_timer(0.3).timeout
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
		var player_path = STORAGE.get_value("player_path")
		get_node(player_path).position = get_node(CAMPFIRE_PATH).position - Vector2(100, 100)
