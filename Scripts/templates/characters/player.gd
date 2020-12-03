tool
extends KinematicBody2D

# Player controller
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

# State types
enum States {DOWN, UP, LEFT, RIGHT}
enum Sprites {MAIN, NEO}
# Sprite frame numbers
enum Frames {DOWN_1, UP_1, SIDE_1,
		DOWN_2, UP_2, SIDE_2,
		DOWN_STILL, UP_STILL, SIDE_STILL}

const MAIN_SPRITE := "res://Sprites/Characters/MainCharacter.png"
const NEO_SPRITE := "res://Sprites/Characters/Neo.png"
const SPEED := 400
const SPRITE_PATH := "Character"

export (States) var default_state = States.UP setget _set_state
export (Sprites) var sprite_sheet = Sprites.MAIN setget _set_sprite
export (bool) var restore_position = false
export (Curve) var speed_curve
export (bool) var locked = false

var _speed_curve_offset := 0.0
# Get input from joystick
# Otherwise use the keyboard
var _use_joystick: bool
# Current state type
var _dir := 0
# Does the character stand still
# Used to reset animation for the first time
var _idle := true
# Has at least one navigation button been pressed
var _any_button_pressed: bool
# Left / Right button pressed
# Used to lock up/down animation
var _left_right_btn_pressed: bool
var _velocity := Vector2(0, 0)

# Used by another scripts
onready var water := $Water
# Objects
onready var _character := $Character
onready var _anim := $WalkCycle
onready var _joystick := $"/root/UI/Joystick/TapButton"


# Lock input
func lock() -> void:
	set_physics_process(false)
	_idle = true
	_anim.stop()
	_freeze_frame(_dir)


# Unlock input
func unlock() -> void:
	set_physics_process(true)


func save_position() -> void:
	var pos = Vector2(position.x, position.y)
	STORAGE.save(SCENES.last_scene_path, pos)


func _set_state(val) -> void:
	default_state = val
	if Engine.editor_hint:
		if has_node(SPRITE_PATH):
			var sprite = get_node(SPRITE_PATH)
			match default_state:
				States.UP:
					sprite.frame = Frames.UP_STILL
				States.DOWN:
					sprite.frame = Frames.DOWN_STILL
				States.RIGHT:
					sprite.flip_h = false
					sprite.frame = Frames.SIDE_STILL
				States.LEFT:
					sprite.flip_h = true
					sprite.frame = Frames.SIDE_STILL


func _set_sprite(val) -> void:
	sprite_sheet = val
	if Engine.editor_hint:
		if has_node(SPRITE_PATH):
			var sprite = get_node(SPRITE_PATH)
			if val == Sprites.NEO:
				sprite.texture = load(NEO_SPRITE)
			elif val == Sprites.MAIN:
				sprite.texture = load(MAIN_SPRITE)


func _ready() -> void:
	STORAGE.save("player_path", get_path())
	if restore_position:
		_try_to_restore_position()
	_dir = default_state
	# Determine the control method
	if OS.get_name() == "Android" or UI.force_joystick:
		_use_joystick = true


func _try_to_restore_position() -> void:
	if STORAGE.is_saved(SCENES.last_scene_path):
		var pos: Vector2 = STORAGE.get(SCENES.last_scene_path)
		position.x = pos.x
		position.y = pos.y


# Invoked constantly
func _physics_process(delta) -> void:
	if not Engine.editor_hint and not locked:
		# If at least one key has been pressed
		if _get_input(delta):
			_velocity = move_and_slide(_velocity)


# Input processing
func _get_input(delta) -> bool:
	_left_right_btn_pressed = false
	_any_button_pressed = false
	if _use_joystick:
		return _joystick_processing(delta)
	return _process_buttons(delta)


func _process_buttons(delta) -> bool:
	# Reset variables
	_velocity = Vector2(0, 0)
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
	if !_idle && !_any_button_pressed:
		_idle = true
		_anim.stop()
		_speed_curve_offset = 0
		_freeze_frame(_dir)
		return false
	# Calculate velocity
	if _speed_curve_offset < 1:
		var multiplier = speed_curve.interpolate_baked(_speed_curve_offset)
		_velocity = _velocity.normalized() * SPEED * multiplier
		_speed_curve_offset += delta
	else:
		_velocity = _velocity.normalized() * SPEED
	return true


func _joystick_processing(delta) -> bool:
	var joystick_value: Vector2 = _joystick.get_value()
	if joystick_value.length() > 0:
		# Calculate velocity
		if _speed_curve_offset < 1:
			var multiplier = speed_curve.interpolate_baked(_speed_curve_offset)
			_velocity = joystick_value * SPEED * multiplier
			_speed_curve_offset += delta
		else:
			_velocity = joystick_value * SPEED
		# Move player
		if abs(_velocity.x) > abs(_velocity.y):
			if _velocity.x > 0:
				go_right()
			else:
				go_left()
		else:
			if _velocity.y > 0:
				go_down()
			else:
				go_up()
		return true
	else:
		if !_idle:
			_idle = true
			_anim.stop()
			_speed_curve_offset = 0
			_freeze_frame(_dir)
		return false


func _freeze_frame(state) -> void:
	match state:
		States.UP:
			_character.frame = Frames.UP_STILL
		States.DOWN:
			_character.frame = Frames.DOWN_STILL
		_:
			_character.frame = Frames.SIDE_STILL


func go_right() -> void:
	_left_right_btn_pressed = true
	_any_button_pressed = true
	# If the character has not been rotated to the right
	if _dir != States.RIGHT or _idle:
		_dir = States.RIGHT
		_character.flip_h = false
		_anim.play("right")
		_idle = false
	_velocity.x += 1


func go_left() -> void:
	_left_right_btn_pressed = true
	_any_button_pressed = true
	# If the character has not been rotated to the left
	if _dir != States.LEFT or _idle:
		_dir = States.LEFT
		_character.flip_h = true
		_anim.play("right")
		_idle = false
	_velocity.x -= 1


func go_down() -> void:
	_any_button_pressed = true
	# Do not play animation 
	# if sideways animation is already playing
	if !_left_right_btn_pressed:
		# If the character has not been turned down
		if _dir != States.DOWN or _idle:
			_dir = States.DOWN
			_character.flip_h = false
			_anim.play("down")
			_idle = false
	_velocity.y += 1


func go_up() -> void:
	_any_button_pressed = true
	# Do not play animation 
	# if sideways animation is already playing
	if !_left_right_btn_pressed:
		# If the character has not been turned up
		if _dir != States.UP or _idle:
			_dir = States.UP
			_character.flip_h = false
			_anim.play("up")
			_idle = false
	_velocity.y -= 1
