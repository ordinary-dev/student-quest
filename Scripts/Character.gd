extends KinematicBody2D

# State types
enum states {DOWN, UP, LEFT, RIGHT}
enum sprites {MAIN, ALEX}
export (states) var default_state = states.UP
export (sprites) var sprite_sheet = sprites.MAIN setget set_sprite
export (bool) var restore_position = false
var restored_position = false
const alex_texture = "res://Sprites/friend_1.png"
const speed := 400

# Objects
onready var character = $Character_Sprite
onready var water_sprite = $Character_Sprite/Water_AnimatedSprite
onready var anim = $WalkCycle_AnimationPlayer

# Get input from joystick
# Otherwise use the keyboard
var use_joystick : bool
var joystick

# Current state type
var type := 0

# Does the character stand still
# Used to reset animation for the first time
var idle := true

# Applied when SHIFT is pressed
var mult := 1

# Has at least one navigation button been pressed
var any_button_pressed : bool

# Left / Right button pressed
# Used to lock up/down animation
var side_used : bool

var velocity : Vector2

# Sprite frame numbers
enum frames {DOWN_1, UP_1, SIDE_1,
	DOWN_2, UP_2, SIDE_2,
	DOWN_STILL, UP_STILL, SIDE_STILL}

# To prevent water splashing
var water_level := 0
var water_protection := false setget set_water_protection


func set_water_protection(val):
	water_protection = val
	if !water_protection:
		if water_level == 1:
			water_sprite.visible = true
			water_sprite.playing = true
	else:
		water_sprite.visible = false
		water_sprite.playing = false


# Lock input
func lock() -> void:
	set_physics_process(false)
	idle = true
	anim.stop()
	match type:
		states.UP:
			character.frame = frames.UP_STILL
		states.DOWN:
			character.frame = frames.DOWN_STILL
		_:
			character.frame = frames.SIDE_STILL


# Unlock input
func unlock() -> void:
	set_physics_process(true)


func enable_water() -> void:
	water_level += 1
	if !water_protection and water_level == 1:
		water_sprite.visible = true
		water_sprite.playing = true


func disable_water() -> void:
	water_level -= 1
	if water_level == 0:
		water_sprite.visible = false
		water_sprite.playing = false


func go_right() -> void:
	side_used = true
	any_button_pressed = true
	# If the character has not been rotated to the right
	if type != states.RIGHT or idle:
		type = states.RIGHT
		character.flip_h = false
		anim.play("right")
		idle = false
	velocity.x += 1


func go_left() -> void:
	side_used = true
	any_button_pressed = true
	# If the character has not been rotated to the left
	if type != states.LEFT or idle:
		type = states.LEFT
		character.flip_h = true
		anim.play("right")
		idle = false
	velocity.x -= 1


func go_down() -> void:
	any_button_pressed = true
	# Do not play animation 
	# if sideways animation is already playing
	if !side_used:
		# If the character has not been turned down
		if type != states.DOWN or idle:
			type = states.DOWN
			character.flip_h = false
			anim.play("down")
			idle = false
	velocity.y += 1


func go_up() -> void:
	any_button_pressed = true
	# Do not play animation 
	# if sideways animation is already playing
	if !side_used:
		# If the character has not been turned up
		if type != states.UP or idle:
			type = states.UP
			character.flip_h = false
			anim.play("up")
			idle = false
	velocity.y -= 1


func joystick_processing() -> bool:
	velocity = joystick.get_value()
	if velocity.length() > 0:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				go_right()
			else:
				go_left()
		else:
			if velocity.y > 0:
				go_down()
			else:
				go_up()
		velocity = joystick.get_value() * speed
		return true
	else:
		if !idle:
			idle = true
			anim.stop()
			match type:
				states.UP:
					character.frame = frames.UP_STILL
				states.DOWN:
					character.frame = frames.DOWN_STILL
				_:
					character.frame = frames.SIDE_STILL
		return false


func process_buttons() -> bool:
	# Reset variables
	velocity = Vector2()
	# Process 4 directions
	if Input.is_action_pressed('ui_right'):
		go_right()
	if Input.is_action_pressed('ui_left'):
		go_left()
	if Input.is_action_pressed('ui_down'):
		go_down()
	if Input.is_action_pressed('ui_up'):
		go_up()
	# If the buttons were not pressed for the first time
	if !idle && !any_button_pressed:
		idle = true
		anim.stop()
		match type:
			states.UP:
				character.frame = frames.UP_STILL
			states.DOWN:
				character.frame = frames.DOWN_STILL
			_:
				character.frame = frames.SIDE_STILL
		return false
	mult = 4 if Input.is_action_pressed("speed_up") else 1
	velocity = velocity.normalized() * speed * mult
	return true


# Input processing
func get_input() -> bool:
	side_used = false
	any_button_pressed = false
	if use_joystick:
		return joystick_processing()
	return process_buttons()


# Invoked constantly
func _physics_process(_delta) -> void:
	# If at least one key has been pressed
	if get_input():
		velocity = move_and_slide(velocity)


func _save() -> void:
	var dict = {
		"player_pos_x": position.x,
		"player_pos_y": position.y
	}
	TEMP.save(SCENES.last_scene_path, dict)


func set_sprite(val) -> void:
	sprite_sheet = val
	if val == sprites.ALEX:
		character.texture = load(alex_texture)
	# else
	# ...


func _ready() -> void:
	GLOBAL.player_path = get_path()
	if restore_position:
		if TEMP.is_saved(SCENES.last_scene_path):
			var pos = TEMP.get(SCENES.last_scene_path)
			position.x = pos["player_pos_x"]
			position.y = pos["player_pos_y"]
			restored_position = true
	# Set starting direction
	match default_state:
		states.UP:
			character.frame = frames.UP_STILL
			type = states.UP
		states.DOWN:
			character.frame = frames.DOWN_STILL
			type = states.DOWN
		states.RIGHT:
			character.frame = frames.SIDE_STILL
			type = states.RIGHT
		states.LEFT:
			character.flip_h = true
			character.frame = frames.SIDE_STILL
			type = states.LEFT
	use_joystick = OS.get_name() == "Android" or UI_INIT.SHOW_CONTROLS
	if use_joystick:
		joystick = UI.get_node("Joystick-UI_Sprite/Tap_Button")
