# Guide Ai

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Sprite

onready var anim = $WalkCycle
export (NodePath) var line_path

var player
var target
var line2d : Line2D
var ind := 0

# Current direction
var cdir = dirs.UNSET

const e := 3
const speed := 400
const max_distance := 250

# Directions
enum dirs {DOWN, UP, LEFT, RIGHT, UNSET}


func distance_between(obj1 : Vector2, obj2 : Vector2) -> float:
	var dx = obj1.x - obj2.x
	var dy = obj1.y - obj2.y
	return sqrt(dx*dx+dy*dy)


func not_equal(x:float, y:float) -> bool:
	return abs(x - y) > e*2


func _process(delta) -> void:
	if position.distance_to(player.position) < max_distance or position.distance_to(target) > distance_between(player.position, target):
		var changed = false
		
		if not_equal(position.x, target.x):
			changed = true
			if position.x < target.x:
				position.x += speed * delta
				if cdir != dirs.RIGHT:
					cdir = dirs.RIGHT
					anim.play("side")
					flip_h = false
			else:
				position.x -= speed * delta
				if cdir != dirs.LEFT:
					cdir = dirs.LEFT
					anim.play("side")
					flip_h = true
		
		if not_equal(position.y, target.y):
			if position.y > target.y:
				position.y -= speed * delta
				if !changed && cdir != dirs.UP:
					cdir = dirs.UP
					anim.play("up")
			else:
				position.y += speed * delta
				if !changed && cdir != dirs.DOWN:
					cdir = dirs.DOWN
					anim.play("down")
			changed = true
		
		# Next point
		if !changed:
			if ind + 1 < line2d.points.size():
				ind += 1
				target = line2d.points[ind]
			else:
				set_process(false)
				anim.stop()
				frame = 6
	else:
		anim.stop()
		frame = 6
		cdir = dirs.UNSET


func _ready() -> void:
	player = get_node(GLOBAL.player_path)
	line2d = get_node(line_path)
	target = line2d.points[ind]
