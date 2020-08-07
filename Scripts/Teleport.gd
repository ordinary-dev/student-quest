extends Node2D

# Teleport
onready var p1_center = $FloorPositions/Floor1_Center
onready var p1_left = $FloorPositions/Floor1_Left
onready var p2 = $FloorPositions/Floor2
onready var p3 = $FloorPositions/Floor3

# Street
export (String, FILE, "*.tscn") var street_scene_path

# Initial player direction
enum directions{UP, DOWN, LEFT, RIGHT}
export (directions) var player_direction = directions.DOWN

# Initial position
enum pos {FIRST_CENTER, FIRST_LEFT, SECOND, THIRD}
export (pos) var initial_pos = pos.SECOND

# Turnstile
export (bool) var block_turnstile = false setget set_turnstile_state
onready var turnstile = $Turnstiles/CollisionShape2D


func set_turnstile_state(value : bool) -> void:
	block_turnstile = value
	if turnstile != null:
		turnstile.disabled = !block_turnstile


func print_warning() -> void:
	NOTIFY.show("NOENTER")


func teleport(node : Position2D, fade = true) -> void:
	if fade:
		SCENES.fade_in()
		yield(get_tree().create_timer(SCENES.time), "timeout")
	get_node(GLOBAL.player_path).position = node.position
	if fade:
		SCENES.fade_out()


func floor_1():
	teleport(p1_center)


func floor_2():
	teleport(p2)


func floor_3():
	teleport(p3)


func street():
	SCENES.load_scene(street_scene_path)


func _ready():
	# The set_block function does not work 
	# the first time because the variable is not ready
	# The state changes here manually
	turnstile.disabled = !block_turnstile
	# Initial position
	if initial_pos == pos.FIRST_CENTER:
		teleport(p1_center, false)
	elif initial_pos == pos.FIRST_LEFT:
		teleport(p1_left, false)
	elif initial_pos == pos.THIRD:
		teleport(p3, false)
	var player = get_node(GLOBAL.player_path)
	match player_direction:
		directions.UP:
			player.go_up()
		directions.RIGHT:
			player.go_right()
		directions.LEFT:
			player.go_left()
