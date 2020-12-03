extends Node2D

# Ai for police officer
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

enum Directions {UP, DOWN, LEFT, RIGHT, UNSET}
const SPEED := 270

export (NodePath) var config_node = NodePath("../AI_Config")

var _path: PoolVector2Array
var _minpos: Vector2
var _maxpos: Vector2
var _nav_2d: Navigation2D
var _cfg: PoliceOfficerConfig
var _current_dir = Directions.UNSET

onready var _ap := $AnimationPlayer
onready var _flashlight := $Flashlight
onready var _sprite := $Sprite


func _ready() -> void:
	_cfg = get_node(config_node)
	# Get min and max position
	_minpos = get_node(_cfg.upper_left_node).position
	_maxpos = get_node(_cfg.bottom_right_node).position
	randomize()
	_nav_2d = get_node(_cfg.nav_node)


func _process(delta) -> void:
	# Officer hasn't reached the last point yet
	if _path.size() > 0:
		var distance_to_walk = SPEED * delta
		var distance_to_next_point = position.distance_to(_path[0])
		if distance_to_walk <= distance_to_next_point:
			# Officer goes to the next point
			var dir := position.direction_to(_path[0])
			# Officer moves up or down
			if abs(dir.y) > abs(dir.x):
				if dir.y < 0:
					if _current_dir != Directions.UP:
						_current_dir = Directions.UP
						_flashlight.rotation_degrees = 0
						_ap.play("Up")
				else:
					if _current_dir != Directions.DOWN:
						_current_dir = Directions.DOWN
						_flashlight.rotation_degrees = 180
						_ap.play("Down")
			# Officer moves right or left
			else:
				if dir.x > 0:
					if _current_dir != Directions.RIGHT:
						_current_dir = Directions.RIGHT
						_flashlight.rotation_degrees = 90
						_ap.play("Side")
						_sprite.flip_h = false
				else:
					if _current_dir != Directions.LEFT:
						_current_dir = Directions.LEFT
						_flashlight.rotation_degrees = -90
						_ap.play("Side")
						_sprite.flip_h = true
			# Move officer
			position += position.direction_to(_path[0]) * distance_to_walk
		# The character approached the destination point
		else:
			position = _path[0]
			_path.remove(0)
	# Officer has reached the last point
	else:
		_ap.stop()
		match _current_dir:
			Directions.UP:
				_sprite.frame = 7
			Directions.DOWN:
				_sprite.frame = 6
			_:
				_sprite.frame = 8
		_current_dir = Directions.UNSET
		var x = rand_range(_minpos.x, _maxpos.x)
		var y = rand_range(_minpos.y, _maxpos.y)
		var point = Vector2(x, y)
		_path = _nav_2d.get_simple_path(position, point)


func _on_Area2D_body_entered(_body) -> void:
	SCENES.load_scene(_cfg.restart_scene, false, false)
