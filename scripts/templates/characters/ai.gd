extends Node2D

# Script for NPCs that go
# to a random point on the map
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

enum Directions {UP, DOWN, LEFT, RIGHT, UNSET}

const MAX_WAITING_TIME := 7
const SPEED := 270
const SPRITE_PATHS := [
	"res://sprites/characters/npc_1.png",
	"res://sprites/characters/npc_2.png",
	"res://sprites/characters/npc_3.png",
]

export (NodePath) var ai_config_path

var _path: PoolVector2Array
var _minpos: Vector2
var _maxpos: Vector2
var _nav_2d: Navigation2D
var _current_dir = Directions.UNSET
var _anim_playing := false
var _cfg

onready var _sprite := $Sprite
onready var _ap := $AnimationPlayer


func _ready() -> void:
	# Select sprite
	var ind := randi() % 3
	_sprite.texture = load(SPRITE_PATHS[ind])
	_cfg = get_node(ai_config_path)
	# Get min and max position
	_minpos = get_node(_cfg.upper_left_node).position
	_maxpos = get_node(_cfg.bottom_right_node).position
	# Generate random path
	randomize()
	_nav_2d = get_node(_cfg.nav_node)
	_generate_path()


func _process(delta) -> void:
	# The character hasn't reached the last point yet
	if _path.size() > 0:
		var distance_to_walk = SPEED * delta
		var distance_to_next_point = position.distance_to(_path[0])
		if distance_to_walk <= distance_to_next_point:
			# The character goes to the next point
			var dir := position.direction_to(_path[0])
			# The character moves up or down
			if abs(dir.y) > abs(dir.x):
				if dir.y < 0:
					if _current_dir != Directions.UP:
						_current_dir = Directions.UP
						_ap.play("Up")
				else:
					if _current_dir != Directions.DOWN:
						_current_dir = Directions.DOWN
						_ap.play("Down")
			# The character moves right or left
			else:
				if dir.x > 0:
					if _current_dir != Directions.RIGHT:
						_current_dir = Directions.RIGHT
						_ap.play("Side")
						_sprite.flip_h = false
				else:
					if _current_dir != Directions.LEFT:
						_current_dir = Directions.LEFT
						_ap.play("Side")
						_sprite.flip_h = true
			# Move character
			position += position.direction_to(_path[0]) * distance_to_walk
		# The character approached the destination point
		else:
			position = _path[0]
			_path.remove(0)
	# The character has reached the last point
	else:
		_ap.stop()
		set_process(false)
		_select_frame(_current_dir)
		_current_dir = Directions.UNSET
		# Stand for a while
		yield(get_tree().create_timer(rand_range(0, MAX_WAITING_TIME)), "timeout")
		_generate_path()


func _generate_path() -> void:
	var x := rand_range(_minpos.x, _maxpos.x)
	var y := rand_range(_minpos.y, _maxpos.y)
	var point := Vector2(x, y)
	_path = _nav_2d.get_simple_path(position, point)
	set_process(true)


# Stop when a player approaches
func _on_Area2D_body_entered(_body) -> void:
	set_process(false)
	_ap.stop()
	_select_frame(_current_dir)
	_current_dir = Directions.UNSET


# Selects the appropriate part
# of the sprite when the character
# stops walking
func _select_frame(dir) -> void:
	match dir:
		Directions.UP:
			_sprite.frame = 7
		Directions.DOWN:
			_sprite.frame = 6
		_:
			_sprite.frame = 8


# Continue walking when the player moves away
func _on_Area2D_body_exited(_body) -> void:
	set_process(true)
