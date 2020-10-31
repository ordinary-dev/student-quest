# Follow path

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Sprite

export (NodePath) var line_path
export (bool) var wait_for_player = true
export (bool) var autostart = true

export (bool) var call_function = false
export (NodePath) var obj
export (String) var fun
export (String) var arg = ""
export (float) var call_delay = 0

var player
var target
var line2d : Line2D
var ind := 0

# Current direction
var cdir = dirs.UNSET

const e := 3
export (int) var speed := 300
const max_distance := 250

# Directions
enum dirs {DOWN, UP, LEFT, RIGHT, UNSET}
enum frames {DOWN_1, UP_1, SIDE_1,
			DOWN_2, UP_2, SIDE_2,
			DOWN_STILL, UP_STILL, SIDE_STILL}

# Animation
var _anim_speed : float = 0.6
var _anim_progress : float = 0


func not_equal(x:float, y:float) -> bool:
	return abs(x - y) > e*2


func _process(delta) -> void:
	if (!wait_for_player or position.distance_to(player.position) < max_distance) or position.distance_to(target) > player.position.distance_to(target):
		var changed = false
		
		if not_equal(position.x, target.x):
			changed = true
			
			# Go right
			if position.x < target.x:
				position.x += speed * delta
				if cdir != dirs.RIGHT:
					cdir = dirs.RIGHT
					flip_h = false
					_anim_progress = 0
					frame = frames.SIDE_1
				else:
					_anim_progress += delta
					if _anim_progress >= _anim_speed:
						_anim_progress = 0
						if frame == frames.SIDE_1:
							frame = frames.SIDE_2
						else:
							frame = frames.SIDE_1
			
			# Go left
			else:
				position.x -= speed * delta
				if cdir != dirs.LEFT:
					cdir = dirs.LEFT
					flip_h = true
					_anim_progress = 0
					frame = frames.SIDE_1
				else:
					_anim_progress += delta
					if _anim_progress >= _anim_speed:
						_anim_progress = 0
						if frame == frames.SIDE_1:
							frame = frames.SIDE_2
						else:
							frame = frames.SIDE_1
		
		if not_equal(position.y, target.y):
			
			# Go up
			if position.y > target.y:
				position.y -= speed * delta
				if !changed && cdir != dirs.UP:
					cdir = dirs.UP
					frame = frames.UP_1
					_anim_progress = 0
				else:
					_anim_progress += delta
					if _anim_progress >= _anim_speed:
						_anim_progress = 0
						if frame == frames.UP_1:
							frame = frames.UP_2
						else:
							frame = frames.UP_1
			
			# Go down
			else:
				position.y += speed * delta
				if !changed && cdir != dirs.DOWN:
					cdir = dirs.DOWN
					frame = frames.DOWN_1
					_anim_progress = 0
				else:
					_anim_progress += delta
					if _anim_progress >= _anim_speed:
						_anim_progress = 0
						if frame == frames.DOWN_1:
							frame = frames.DOWN_2
						else:
							frame = frames.DOWN_1
			changed = true
		
		# Next point
		if !changed:
			if ind + 1 < line2d.points.size():
				ind += 1
				target = line2d.points[ind]
			else:
				set_process(false)
				if call_function:
					if call_delay > 0:
						yield(get_tree().create_timer(call_delay), "timeout")
					if (arg == ""):
						get_node(obj).call_deferred(fun)
					else:
						get_node(obj).call_deferred(fun, arg)
				frame = frames.DOWN_STILL
	else:
		frame = frames.DOWN_STILL
		cdir = dirs.UNSET


func _ready() -> void:
	player = get_node(GLOBAL.player_path)
	line2d = get_node(line_path)
	target = line2d.points[ind]
	if autostart == false:
		set_process(false)


func follow_path() -> void:
	set_process(true)
