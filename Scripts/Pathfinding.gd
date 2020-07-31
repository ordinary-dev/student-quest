extends Node2D

var path : PoolVector2Array
export (NodePath) var nav_node = NodePath("../Navigation2D")

export (NodePath) var upper_left_node
export (NodePath) var bottom_right_node

export (int) var scene_ind = 0

var x_min
var y_min
var x_max
var y_max

var nav_2d
var upper_left : Position2D
var bottom_right : Position2D

enum DIRECTIONS{UP, DOWN, LEFT, RIGHT, UNSET}
var current_dir = DIRECTIONS.UNSET
var anim_playing := false

const speed = 270

func _ready() -> void:
	upper_left = get_node(upper_left_node)
	bottom_right = get_node(bottom_right_node)
	x_min = upper_left.position.x
	y_min = upper_left.position.y
	x_max = bottom_right.position.x
	y_max = bottom_right.position.y
	randomize()
	nav_2d = get_node(nav_node)


func _process(delta):
	var distance_to_walk = speed * delta
	
	if path.size() > 0:
		var distance_to_next_point = position.distance_to(path[0])
		if distance_to_walk <= distance_to_next_point:
			# The player does not have enough movement left to get to the next point.
			var dir := position.direction_to(path[0])
			if abs(dir.y) > abs(dir.x):
				if dir.y < 0:
					if current_dir != DIRECTIONS.UP:
						current_dir = DIRECTIONS.UP
						$Flashlight.rotation_degrees = 0
						$AnimationPlayer.play("Up")
				else:
					if current_dir != DIRECTIONS.DOWN:
						current_dir = DIRECTIONS.DOWN
						$Flashlight.rotation_degrees = 180
						$AnimationPlayer.play("Down")
			else:
				if dir.x > 0:
					if current_dir != DIRECTIONS.RIGHT:
						current_dir = DIRECTIONS.RIGHT
						$Flashlight.rotation_degrees = 90
						$AnimationPlayer.play("Side")
						$npc.flip_h = false
				else:
					if current_dir != DIRECTIONS.LEFT:
						current_dir = DIRECTIONS.LEFT
						$Flashlight.rotation_degrees = -90
						$AnimationPlayer.play("Side")
						$npc.flip_h = true
			position += position.direction_to(path[0]) * distance_to_walk
		else:
			# The player get to the next point
			position = path[0]
			path.remove(0)
	else:
		$AnimationPlayer.stop()
		match current_dir:
			DIRECTIONS.UP:
				$npc.frame = 7
			DIRECTIONS.DOWN:
				$npc.frame = 6
			_:
				$npc.frame = 8
		current_dir = DIRECTIONS.UNSET
		var x = rand_range(0, x_max)
		var y = rand_range(0, y_max)
		var point = Vector2(x, y)
		var new_path = nav_2d.get_simple_path(position, point)
		path = new_path


func _on_Area2D_body_entered(body):
	if scene_ind == 0:
		SCENES.load_scene("res://Scenes/Hope/13.Hit.tscn")
	else:
		SCENES.load_scene("res://Scenes/Hope/19.Hit.tscn")
