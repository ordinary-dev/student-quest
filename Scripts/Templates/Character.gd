extends KinematicBody2D

# State types
enum states {DOWN, UP, LEFT, RIGHT}
enum sprites {MAIN, NEO}
export (states) var default_state = states.UP
export (sprites) var sprite_sheet = sprites.MAIN setget set_sprite
export (bool) var restore_position = false
var restored_position = false
const main_texture = "res://Sprites/Characters/MainCharacter.png"
const neo_texture = "res://Sprites/Characters/Neo.png"
const speed := 400

# Speed curve
export (Curve) var speed_curve
var offset : float
var multiplier : float

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

export (bool) var locked := false

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


func joystick_processing(_delta) -> bool:
	var joystick_value : Vector2 = joystick.get_value()
	if joystick_value.length() > 0:
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
		if (offset < 1):
			multiplier = speed_curve.interpolate_baked (offset)
			velocity = joystick_value * speed * multiplier
			offset += _delta
		else:
			velocity = joystick_value * speed
		return true
	else:
		if !idle:
			idle = true
			anim.stop()
			offset = 0
			match type:
				states.UP:
					character.frame = frames.UP_STILL
				states.DOWN:
					character.frame = frames.DOWN_STILL
				_:
					character.frame = frames.SIDE_STILL
		return false


func process_buttons(_delta) -> bool:
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
		offset = 0
		match type:
			states.UP:
				character.frame = frames.UP_STILL
			states.DOWN:
				character.frame = frames.DOWN_STILL
			_:
				character.frame = frames.SIDE_STILL
		return false
	# Speed curve
	if (offset < 1):
		multiplier = speed_curve.interpolate_baked (offset)
		velocity = velocity.normalized() * speed * multiplier
		offset += _delta
	else:
		velocity = velocity.normalized() * speed
	return true


# Input processing
func get_input(_delta) -> bool:
	side_used = false
	any_button_pressed = false
	if use_joystick:
		return joystick_processing(_delta)
	return process_buttons(_delta)


# Invoked constantly
func _physics_process(_delta) -> void:
	if not locked:
		# If at least one key has been pressed
		if get_input(_delta):
			velocity = move_and_slide(velocity)


func _save() -> void:
	var dict = {
		"player_pos_x": position.x,
		"player_pos_y": position.y
	}
	STORAGE.save(SCENES.last_scene_path, dict)


func set_sprite(val) -> void:
	sprite_sheet = val
	if val == sprites.NEO:
		character.texture = load(neo_texture)
	elif val == sprites.MAIN:
		character.texture = load(main_texture)


func _ready() -> void:
	STORAGE.save("player_path", get_path())
	if restore_position:
		if STORAGE.is_saved(SCENES.last_scene_path):
			var pos = STORAGE.get(SCENES.last_scene_path)
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
	if OS.get_name() == "Android" or UI.force_joystick:
		use_joystick = true
		joystick = UI.get_node("Joystick-UI/TapButton")
