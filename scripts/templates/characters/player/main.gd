tool
extends KinematicBody2D

# Player controller
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

# State types
enum States {DOWN, UP, LEFT, RIGHT}
enum Sprites {MAIN, NEO}
export (Sprites) var sprite_sheet = Sprites.MAIN setget set_sprite
# Sprite frame numbers
enum Frames {DOWN_1, UP_1, SIDE_1,
		DOWN_2, UP_2, SIDE_2,
		DOWN_STILL, UP_STILL, SIDE_STILL}

# Movement
const SPEED := 120
const FRICTION := 0.65

# Used to get nodes in editor mode
const CAMERA_PATH := "Camera2D"
const SPRITE_PATH := "Sprite"

export (States) var default_state = States.UP setget _set_state
export (bool) var restore_position = false
export (bool) var locked = false
export (int) var camera_limit_left = -10000000 setget _set_cl_left
export (int) var camera_limit_top = -10000000 setget _set_cl_top
export (int) var camera_limit_right = 10000000 setget _set_cl_right
export (int) var camera_limit_bottom = 10000000 setget _set_cl_bottom
export (float) var camera_zoom = 0.6 setget _set_camera_zoom

# Get input from joystick
# Otherwise use the keyboard
var _use_joystick: bool
# Current state type
var _dir := 0
# Does the character stand still
# Used to reset animation for the first time
var _idle := true
# Left / Right button pressed
# Used to lock up/down animation
var _left_right_btn_pressed := false
var _velocity := Vector2(0, 0)

# Used by another scripts
onready var water := $Water
# Objects
onready var _anim := $WalkCycle
onready var _joystick_handler := $JoystickHandler
onready var _keyboard_handler := $KeyboardHandler
onready var _sprite: Sprite = $Sprite


func set_sprite(val) -> void:
	sprite_sheet = val
	match sprite_sheet:
		Sprites.NEO:
			_sprite.load_neo_sprite()
		Sprites.MAIN:
			_sprite.load_main_sprite()


# Lock input
func lock() -> void:
	set_physics_process(false)
	_idle = true
	_anim.stop()
	_sprite._freeze_frame(_dir)


# Unlock input
func unlock() -> void:
	set_physics_process(true)


func save_position() -> void:
	var pos = Vector2(position.x, position.y)
	STORAGE.save(SCENES.last_scene_path, pos)


func turn_right() -> void:
	_dir = States.RIGHT
	_sprite.flip_h = false
	_sprite.frame = Frames.SIDE_STILL


func turn_left() -> void:
	_dir = States.LEFT
	_sprite.flip_h = true
	_sprite.frame = Frames.SIDE_STILL


func turn_down() -> void:
	_dir = States.DOWN
	_sprite.flip_h = false
	_sprite.frame = Frames.DOWN_STILL


func turn_up() -> void:
	_dir = States.UP
	_sprite.flip_h = false
	_sprite.frame = Frames.UP_STILL


func _move_right() -> void:
	_left_right_btn_pressed = true
	# If the character has not been rotated to the right
	if _dir != States.RIGHT or _idle:
		_dir = States.RIGHT
		_sprite.flip_h = false
		_anim.play("right")


func _move_left() -> void:
	_left_right_btn_pressed = true
	# If the character has not been rotated to the left
	if _dir != States.LEFT or _idle:
		_dir = States.LEFT
		_sprite.flip_h = true
		_anim.play("right")


func _move_down() -> void:
	# Do not play animation 
	# if sideways animation is already playing
	if !_left_right_btn_pressed:
		# If the character has not been turned down
		if _dir != States.DOWN or _idle:
			_dir = States.DOWN
			_sprite.flip_h = false
			_anim.play("down")


func _move_up() -> void:
	# Do not play animation 
	# if sideways animation is already playing
	if !_left_right_btn_pressed:
		# If the character has not been turned up
		if _dir != States.UP or _idle:
			_dir = States.UP
			_sprite.flip_h = false
			_anim.play("up")


# Set camera limit
func _set_cl_left(val: int) -> void:
	camera_limit_left = val
	var cam = get_node(CAMERA_PATH)
	cam.limit_left = camera_limit_left


func _set_cl_top(val: int) -> void:
	camera_limit_top = val
	var cam = get_node(CAMERA_PATH)
	cam.limit_top = camera_limit_top


func _set_cl_right(val: int) -> void:
	camera_limit_right = val
	var cam = get_node(CAMERA_PATH)
	cam.limit_right = camera_limit_right


func _set_cl_bottom(val: int) -> void:
	camera_limit_bottom = val
	var cam = get_node(CAMERA_PATH)
	cam.limit_bottom = camera_limit_bottom


func _set_camera_zoom(val: float) -> void:
	camera_zoom = val
	var cam = get_node(CAMERA_PATH)
	cam.zoom = Vector2(camera_zoom, camera_zoom)


func _set_state(val) -> void:
	default_state = val
	if has_node(SPRITE_PATH):
		var s = get_node(SPRITE_PATH)
		match default_state:
			States.UP:
				s.frame = Frames.UP_STILL
			States.DOWN:
				s.frame = Frames.DOWN_STILL
			States.RIGHT:
				s.flip_h = false
				s.frame = Frames.SIDE_STILL
			States.LEFT:
				s.flip_h = true
				s.frame = Frames.SIDE_STILL


func _ready() -> void:
	if not Engine.editor_hint:
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
func _physics_process(_delta) -> void:
	if not Engine.editor_hint and not locked:
		var dir = Vector2()
		_left_right_btn_pressed = false
		if _use_joystick:
			dir = _joystick_handler.get_joystick_input()
		else:
			dir = _keyboard_handler.get_keyboard_input()
		if dir.length() == 0:
			if not _idle:
				_anim.stop()
				_sprite._freeze_frame(_dir)
				_idle = true
		else:
			if dir.x > 0:
				_move_right()
			elif dir.x < 0:
				_move_left()
			if dir.y > 0:
				_move_down()
			elif dir.y < 0:
				_move_up()
			_idle = false
		_velocity += dir * SPEED
		_velocity = move_and_slide(_velocity)
		_velocity *= FRICTION
