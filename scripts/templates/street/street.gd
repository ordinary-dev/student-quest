extends Node2D

# Street template
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

enum Positions {HOSTEL, FOUNTAIN, FACULTY, SOUTH_ENTRANCE, FAC_OF_HUMANITIES}
enum PlayerSprite {MAIN, NEO}
enum Directions {UP, DOWN, LEFT, RIGHT}

export (Positions) var initial_position = Positions.HOSTEL
export (PlayerSprite) var player_sprite = PlayerSprite.MAIN
export (Directions) var initial_direction = Directions.RIGHT
export (bool) var allow_entrance = false
export (String, FILE, "*.tscn") var next_scene
export (bool) var show_singer = true
export (bool) var show_gardener = true
export (bool) var enable_npc = true
export (bool) var enable_lights = true

onready var _trigger := $Triggers/Mathematics
onready var _singer := $MrSinger
onready var _gardener := $YSort/Gardener
onready var _ai := $YSort/AI
onready var _streetlights := $YSort/Streetlights
# Initial positions
onready var _hostel_pos := $Positions/Hostel_Position2D
onready var _fountain_pos := $Positions/Fountain_Position2D
onready var _faculty_pos := $Positions/Faculty_Position2D
onready var _south_entrance := $Positions/South_Entrance_Position2D
onready var _fac_of_humanities := $Positions/Fac_Of_Humanities_Position2D


func enter_the_building():
	SCENES.load_scene(next_scene)


func _ready() -> void:
	var player_path = STORAGE.get("player_path")
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
