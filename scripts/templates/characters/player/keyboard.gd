extends Node


func get_keyboard_input() -> Vector2:
	# Reset variables
	var velocity = Vector2(0, 0)
	# Process 4 directions
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	return velocity
