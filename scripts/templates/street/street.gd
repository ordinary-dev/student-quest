extends Node2D

# Street template
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

enum Positions {HOSTEL, FOUNTAIN, FACULTY, SOUTH_ENTRANCE, FAC_OF_HUMANITIES}
enum PlayerSprite {MAIN, NEO}
enum Directions {UP, DOWN, LEFT, RIGHT}

@export var initial_position: Positions = Positions.HOSTEL
@export var player_sprite: PlayerSprite = PlayerSprite.MAIN
@export var initial_direction: Directions = Directions.RIGHT
@export var allow_entrance: bool = false
@export_file ("*.tscn") var next_scene
@export var show_singer: bool = true
@export var show_gardener: bool = true
@export var enable_npc: bool = true
@export var enable_lights: bool = true

@onready var _trigger := $Triggers/Mathematics
@onready var _singer := $MrSinger
@onready var _gardener := $Node2D/Gardener
@onready var _ai := $Node2D/AI
@onready var _streetlights := $Node2D/Streetlights
# Initial positions
@onready var _hostel_pos := $Positions/Hostel_Position2D
@onready var _fountain_pos := $Positions/Fountain_Position2D
@onready var _faculty_pos := $Positions/Faculty_Position2D
@onready var _south_entrance := $Positions/South_Entrance_Position2D
@onready var _fac_of_humanities := $Positions/Fac_Of_Humanities_Position2D


func enter_the_building():
	SCENES.load_scene(next_scene)


func _ready() -> void:
	var player_path = STORAGE.get_value("player_path")
	assert(has_node(player_path))
	var player = get_node(player_path)
	
	if player_sprite == PlayerSprite.NEO:
		player.sprite_sheet = player.Sprites.NEO
	
	# Do not overwrite position if it was saved
	if STORAGE.is_saved(SCENES.last_scene_path) == false:
		_move_player(player)
	_rotate_player(player)
	
	# Buildings
	if !allow_entrance:
		_trigger.queue_free()
	# Singer
	if !show_singer:
		_singer.queue_free()
	# Gardener
	if !show_gardener:
		_gardener.queue_free()
	# NPC
	if !enable_npc:
		_ai.queue_free()
	
	# Lights
	if !enable_lights:
		var arr = _streetlights.get_children()
		for i in arr:
			i.enable_light = false


func _move_player(player) -> void:
	match initial_position:
		Positions.HOSTEL:
			player.position = _hostel_pos.position
		Positions.FOUNTAIN:
			player.position = _fountain_pos.position
		Positions.FACULTY:
			player.position = _faculty_pos.position
		Positions.SOUTH_ENTRANCE:
			player.position = _south_entrance.position
		Positions.FAC_OF_HUMANITIES:
			player.position = _fac_of_humanities.position


func _rotate_player(player) -> void:
	match initial_direction:
		Directions.UP:
			player.turn_up()
		Directions.DOWN:
			player.turn_down()
		Directions.RIGHT:
			player.turn_right()
		Directions.LEFT:
			player.turn_left()
