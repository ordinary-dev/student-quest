# Street template

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Node2D

# Position
enum positions {HOSTEL, FOUNTAIN, FACULTY, SOUTH_ENTRANCE}
export (positions) var initial_position = positions.HOSTEL
export (bool) var use_alex_texture = false

# Directions
enum dirs {UP, DOWN, LEFT, RIGHT}
export (dirs) var init_dir = dirs.RIGHT

# Scenes
export (bool) var allow_entrance = false
export (String, FILE, "*.tscn") var math_scene

# Mr. Singer
export (bool) var show_singer = true
onready var singer = $MrSinger

# Gardener
export (bool) var show_gardener = true
onready var gardener = $YSort/Gardener

# Streetlights
export (bool) var enable_lights = true
onready var streetlights = $YSort/Streetlights

# NPC
export (bool) var enable_npc = true
onready var ai = $YSort/AI

# Entrance
onready var entrance = $Triggers/Mathematics

# Position
onready var hostel_pos = $Positions/Hostel_Position2D
onready var fountain_pos = $Positions/Fountain_Position2D
onready var faculty_pos = $Positions/Faculty_Position2D
onready var south_entrance = $Positions/South_Entrance_Position2D


func init() -> void:
	var player = get_node(GLOBAL.player_path)
	match initial_position:
		positions.HOSTEL:
			player.position = hostel_pos.position
		positions.FOUNTAIN:
			player.position = fountain_pos.position
		positions.FACULTY:
			player.position = faculty_pos.position
		positions.SOUTH_ENTRANCE:
			player.position = south_entrance.position



func _ready() -> void:
	var player = get_node(GLOBAL.player_path)
	
	if use_alex_texture:
		player.sprite_sheet = player.sprites.ALEX
	
	# Do not overwrite position if it was saved
	if player.restored_position == false:
		init()
	
	# Direction
	match init_dir:
		dirs.UP:
			player.go_up()
		dirs.DOWN:
			player.go_down()
		dirs.RIGHT:
			player.go_right()
		dirs.LEFT:
			player.go_left()
	
	# Buildings
	if !allow_entrance:
		entrance.queue_free()
	
	# Singer
	if !show_singer:
		singer.queue_free()
	
	# Gardener
	if !show_gardener:
		gardener.queue_free()
	
	# Lights
	if !enable_lights:
		var arr = streetlights.get_children()
		for i in arr:
			i.enable_light = false
	
	# NPC
	if !enable_npc:
		ai.queue_free()

 
func math():
	SCENES.load_scene(math_scene)
