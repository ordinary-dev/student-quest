extends Node2D

# Teleport
export (NodePath) var p1
export (NodePath) var p2
export (NodePath) var p3
export (String, FILE, "*.tscn") var street_path
enum directions{UP, DOWN, LEFT, RIGHT}
export (directions) var player_direction = directions.DOWN
enum pos {first, second, third}
export (pos) var initial_pos = pos.second

export (bool) var block_turnstile = false setget set_block, get_block
onready var turnstile = $Turnstiles_StaticBody2D/Turnstiles_CollisionShape2D


func set_block(value : bool) -> void:
	block_turnstile = value
	if turnstile != null:
		turnstile.disabled = !block_turnstile


func get_block() -> bool:
	return block_turnstile


func blocked() -> void:
	NOTIFY.show("NOENTER")


func teleport(node : String, fade = true) -> void:
	if fade:
		SCENES.fade_in()
		yield(get_tree().create_timer(SCENES.time), "timeout")
	get_node(GLOBAL.player_path).position = get_node(node).position
	if fade:
		SCENES.fade_out()


func floor_1():
	teleport(p1)


func floor_2():
	teleport(p2)


func floor_3():
	teleport(p3)


func street():
	SCENES.load_scene(street_path)


func _ready():
	# The set_block function does not work 
	# the first time because the variable is not ready
	# The state changes here manually
	turnstile.disabled = !block_turnstile
	# Initial position
	if initial_pos == pos.first:
		teleport(p1, false)
	elif initial_pos == pos.third:
		teleport(p3, false)
	match player_direction:
		directions.UP:
			$YSort/Body.go_up()
		directions.RIGHT:
			$YSort/Body.go_right()
		directions.LEFT:
			$YSort/Body.go_left()
