extends KinematicBody2D

export (int) var speed = 100
var velocity = Vector2()
onready var character = $Character
var distance_passed = 0
export (int) var change = 10
var type = 0

func lock():
	set_physics_process(false)

func unlock():
	set_physics_process(true)

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		if type != 0:
			distance_passed = 0
			type = 0
			character.frame = 0
		distance_passed += 1
		if distance_passed >= change:
			if character.frame == 0:
				character.frame = 2
			else:
				character.frame = 0
			distance_passed = 0
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		if type != 1:
			distance_passed = 0
			type = 1
			character.frame = 1
		distance_passed += 1
		if distance_passed >= change:
			if character.frame == 1:
				character.frame = 3
			else:
				character.frame = 1
			distance_passed = 0
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
