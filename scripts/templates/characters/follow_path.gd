extends Sprite

# Ai that follows the path
# Just put it on a standard sprite
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

# Directions
enum dirs {DOWN, UP, LEFT, RIGHT, UNSET}
enum frames {DOWN_1, UP_1, SIDE_1,
			DOWN_2, UP_2, SIDE_2,
			DOWN_STILL, UP_STILL, SIDE_STILL}

const E := 4
const MAX_DISTANCE := 250
# Lower is faster...
const ANIMATION_SPEED := 0.4

export (NodePath) var line_path
export (bool) var wait_for_player = true
export (bool) var autostart = true
export (bool) var call_function = false
export (NodePath) var obj
export (String) var fun = "function"
export (String) var arg = ""
export (float) var call_delay = 0
export (int) var speed := 380

var _player: KinematicBody2D
var _target: Vector2
var _line2d: Line2D
var _index := 0
var _current_dir = dirs.UNSET
var _anim_progress := 0.0


func follow_path() -> void:
	set_process(true)


func _process(delta: float) -> void:
	if (!wait_for_player or
		position.distance_to(_player.position) < MAX_DISTANCE or
		position.distance_to(_target) > _player.position.distance_to(_target)):
		var changed = false
		# X
		if _not_equal(position.x, _target.x):
			changed = true
			if position.x < _target.x:
				_go_right(delta)
			else:
				_go_left(delta)
		# Y
		if _not_equal(position.y, _target.y):
			if position.y > _target.y:
				_go_up(delta, changed)
			else:
				_go_down(delta, changed)
			changed = true
		# Next point
		if !changed:
			if _index + 1 < _line2d.points.size():
				_index += 1
				_target = _line2d.points[_index]
			else:
				set_process(false)
				if call_function:
					if call_delay > 0:
						yield(get_tree().create_timer(call_delay), "timeout")
					if arg == "":
						get_node(obj).call_deferred(fun)
					else:
						get_node(obj).call_deferred(fun, arg)
				frame = frames.DOWN_STILL
	else:
		frame = frames.DOWN_STILL
		_current_dir = dirs.UNSET


func _not_equal(x: float, y: float) -> bool:
	return abs(x - y) > E


func _go_right(delta: float) -> void:
	position.x += speed * delta
	if _current_dir != dirs.RIGHT:
		_current_dir = dirs.RIGHT
		flip_h = false
		_anim_progress = 0
		frame = frames.SIDE_1
	else:
		_anim_progress += delta
		if _anim_progress >= ANIMATION_SPEED:
			_anim_progress = 0
			frame = frames.SIDE_2 if frame == frames.SIDE_1 else frames.SIDE_1


func _go_left(delta: float) -> void:
	position.x -= speed * delta
	if _current_dir != dirs.LEFT:
		_current_dir = dirs.LEFT
		flip_h = true
		_anim_progress = 0
		frame = frames.SIDE_1
	else:
		_anim_progress += delta
		if _anim_progress >= ANIMATION_SPEED:
			_anim_progress = 0
			frame = frames.SIDE_2 if frame == frames.SIDE_1 else frames.SIDE_1


func _go_up(delta: float, blocked: float) -> void:
	position.y -= speed * delta
	if !blocked and _current_dir != dirs.UP:
		_current_dir = dirs.UP
		frame = frames.UP_1
		_anim_progress = 0
	else:
		_anim_progress += delta
		if _anim_progress >= ANIMATION_SPEED:
			_anim_progress = 0
			frame = frames.UP_2 if frame == frames.UP_1 else frames.UP_1


func _go_down(delta: float, blocked: bool) -> void:
	position.y += speed * delta
	if !blocked and _current_dir != dirs.DOWN:
		_current_dir = dirs.DOWN
		frame = frames.DOWN_1
		_anim_progress = 0
	else:
		_anim_progress += delta
		if _anim_progress >= ANIMATION_SPEED:
			_anim_progress = 0
			frame = frames.DOWN_2 if frame == frames.DOWN_1 else frames.DOWN_1


func _ready() -> void:
	var player_path = STORAGE.get("player_path")
	_player = get_node(player_path)
	_line2d = get_node(line_path)
	_target = _line2d.points[_index]
	if autostart == false:
		set_process(false)
