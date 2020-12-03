extends Node2D

enum Directions {UP, DOWN, LEFT, RIGHT}
enum Positions {FIRST_CENTER, FIRST_LEFT, SECOND, THIRD}

export (String, FILE, "*.tscn") var street_scene_path
export (Directions) var player_direction = Directions.DOWN
export (Positions) var initial_pos = Positions.SECOND
export (bool) var block_turnstile = false setget set_turnstile_state
export (bool) var show_security_guard = true

onready var _turnstile = $Turnstiles/CollisionShape2D
onready var _p1_center = $FloorPositions/Floor1_Center
onready var _p1_left = $FloorPositions/Floor1_Left
onready var _p2 = $FloorPositions/Floor2
onready var _p3 = $FloorPositions/Floor3
onready var _security_guard = $YSort/Guard


func set_turnstile_state(value : bool) -> void:
	block_turnstile = value
	if _turnstile != null:
		_turnstile.disabled = !block_turnstile


func print_warning() -> void:
	NOTIFY.show("NOENTER")


func teleport(node : Position2D, fade = true) -> void:
	if fade:
		SCENES._fade_in()
		yield(get_tree().create_timer(SCENES.TIME), "timeout")
	var player_path = STORAGE.get("player_path")
	get_node(player_path).position = node.position
	if fade:
		SCENES._fade_out()


func floor_1():
	teleport(_p1_center)


func floor_2():
	teleport(_p2)


func floor_3():
	teleport(_p3)


func street():
	SCENES.load_scene(street_scene_path)


func _ready():
	# The set_block function does not work 
	# the first time because the variable is not ready
	# The state changes here manually
	_turnstile.disabled = !block_turnstile
	# Initial position
	if initial_pos == Positions.FIRST_CENTER:
		teleport(_p1_center, false)
	elif initial_pos == Positions.FIRST_LEFT:
		teleport(_p1_left, false)
	elif initial_pos == Positions.THIRD:
		teleport(_p3, false)
	# Disable security guard if needed
	if not show_security_guard:
		_security_guard.queue_free()
	# Player direction
	var player_path = STORAGE.get("player_path")
	var player = get_node(player_path)
	match player_direction:
		Directions.UP:
			player.go_up()
		Directions.RIGHT:
			player.go_right()
		Directions.LEFT:
			player.go_left()
