extends KinematicBody2D

export (int) var speed = 100
var velocity = Vector2()
onready var character = $Character
var distance_passed = 0
export (int) var change = 10
var type = 0
var side_used = false
var any_button_pressed : bool = false
var idle = true

# Sound
export (AudioStream) var step1
export (AudioStream) var step2
onready var player = $AudioStreamPlayer
var first_stage : bool = false


func lock():
	set_physics_process(false)

func unlock():
	set_physics_process(true)

func play_step():
	if first_stage:
		player.stream = step1
	else:
		player.stream = step2
	first_stage = !first_stage
	player.play()

func get_input():
	velocity = Vector2()
	any_button_pressed = false
	side_used = false
	# Вправо
	if Input.is_action_pressed('ui_right'):
		idle = false
		side_used = true
		any_button_pressed = true
		# Если предыдущее состояние не "вправо"
		if type != 3:
			type = 3
			# Обнулить счетчик для анимации
			distance_passed = 0
			character.frame = 2
			character.flip_h = false
		distance_passed += 1
		# Анимация
		# Крайнее положение
		if distance_passed == change:
			character.frame = 5
			play_step()
		elif distance_passed == 2 * change:
			character.frame = 8
		# Крайнее положение
		elif distance_passed == 3 * change:
			character.frame = 2
			play_step()
		# Обратный порядок
		elif distance_passed == 4 * change:
			character.frame = 8
			distance_passed = 0
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		idle = false
		side_used = true
		any_button_pressed = true
		if type != 2:
			distance_passed = 0
			type = 2
			character.frame = 2
			character.flip_h = true
		distance_passed += 1
		# Крайнее положение
		if distance_passed == change:
			character.frame = 5
			play_step()
		elif distance_passed == 2 * change:
			character.frame = 8
		# Крайнее положение
		elif distance_passed == 3 * change:
			character.frame = 2
			play_step()
		# Обратный порядок
		elif distance_passed == 4 * change:
			character.frame = 8
			distance_passed = 0
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		idle = false
		any_button_pressed = true
		if type != 0 && !side_used:
			distance_passed = 0
			type = 0
			character.frame = 0
			character.flip_h = false
		if !side_used:
			distance_passed += 1
			# Крайнее положение
			if distance_passed == change:
				character.frame = 0
				play_step()
			elif distance_passed == 3 * change:
				character.frame = 3
				play_step()
			elif distance_passed == 4 * change:
				distance_passed = 0 
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		idle = false
		any_button_pressed = true
		if type != 1 && !side_used:
			distance_passed = 0
			type = 1
			character.frame = 1
			character.flip_h = false
		if !side_used:
			distance_passed += 1
			# Крайнее положение
			if distance_passed == change:
				character.frame = 1
				play_step()
			elif distance_passed == 3 * change:
				character.frame = 4
				play_step()
			elif distance_passed == 4 * change:
				distance_passed = 0 
		velocity.y -= 1
	if !any_button_pressed && !idle:
		idle = true
		if type == 1:
			character.frame = 7
		elif type == 0:
			character.frame = 6
		# Left or right
		else:
			character.frame = 8
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	
func _ready():
	# Заставить интерфейс следовать за собой
	get_node("Character/Camera2D/RemoteTransform2D").remote_path = "/root/ui"
