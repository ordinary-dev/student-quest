extends Node2D

enum Directions {UP, DOWN, LEFT, RIGHT}
enum Positions {FIRST, SECOND, THIRD}

@export_file("*.tscn") var street_scene_path
@export var player_direction: Directions = Directions.DOWN
@export var initial_pos: Positions = Positions.SECOND
@export var block_turnstile: bool = false: set = set_turnstile_state
@export var show_security_guard: bool = true

@onready var _turnstile = $Turnstiles/CollisionShape2D
@onready var _p1 = $FloorPositions/Floor1
@onready var _p2 = $FloorPositions/Floor2
@onready var _p3 = $FloorPositions/Floor3
@onready var _security_guard = $Node2D/Guard


func set_turnstile_state(value : bool) -> void:
	block_turnstile = value
	if _turnstile != null:
		_turnstile.disabled = !block_turnstile


func print_warning() -> void:
	NOTIFY.show("NOENTER")


func teleport(node : Marker2D, fade = true) -> void:
	if fade:
		SCENES._fade_in()
		await get_tree().create_timer(SCENES.TIME).timeout
	var player_path = STORAGE.get_value("player_path")
	get_node(player_path).position = node.position
	if fade:
		SCENES._fade_out()


func floor_1():
	teleport(_p1)


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
	if initial_pos == Positions.FIRST:
		teleport(_p1, false)
	elif initial_pos == Positions.THIRD:
		teleport(_p3, false)
	# Disable security guard if needed
	if not show_security_guard:
		_security_guard.queue_free()
	# Player direction
	var player_path = STORAGE.get_value("player_path")
	var player = get_node(player_path)
	match player_direction:
		Directions.UP:
			player.turn_up()
		Directions.RIGHT:
			player.turn_right()
		Directions.LEFT:
			player.turn_left()
