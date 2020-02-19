extends KinematicBody2D

export (int) var speed = 100
var velocity = Vector2()
onready var character = $Character


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		character.frame = 0
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		character.frame = 1
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
