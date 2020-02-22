extends KinematicBody2D

export (int) var speed = 100
var velocity = Vector2()
onready var character = $Character
var distance_passed = 0
export (int) var change = 10
var type = 0
var side_used = false


func lock():
	set_physics_process(false)

func unlock():
	set_physics_process(true)

func get_input():
	velocity = Vector2()
	side_used = false
	if Input.is_action_pressed('ui_right'):
		side_used = true
		if type != 3:
			distance_passed = 0
			type = 3
			character.frame = 2
			character.flip_h = false
		distance_passed += 1
		if distance_passed >= change:
			if character.frame == 2:
				character.frame = 5
			else:
				character.frame = 2
			distance_passed = 0
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		side_used = true
		if type != 2:
			distance_passed = 0
			type = 2
			character.frame = 2
			character.flip_h = true
		distance_passed += 1
		if distance_passed >= change:
			if character.frame == 2:
				character.frame = 5
			else:
				character.frame = 2
			distance_passed = 0
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		if type != 0 && !side_used:
			distance_passed = 0
			type = 0
			character.frame = 0
			character.flip_h = false
		if !side_used:
			distance_passed += 1
			if distance_passed >= change:
				if character.frame == 0:
					character.frame = 3
				else:
					character.frame = 0
				distance_passed = 0
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		if type != 1 && !side_used:
			distance_passed = 0
			type = 1
			character.frame = 1
			character.flip_h = false
		if !side_used:
			distance_passed += 1
			if distance_passed >= change:
				if character.frame == 1:
					character.frame = 4
				else:
					character.frame = 1
				distance_passed = 0
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
