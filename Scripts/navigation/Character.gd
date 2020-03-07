extends KinematicBody2D


# Настройки передвижения
# Скорость
export (int) var speed = 100
# Задержка между сменой кадров
export (int) var change = 10

# Объекты
onready var character = $Character
# Звук
onready var player = $AudioStreamPlayer
onready var player2 = $AudioStreamPlayer2

# Переменные, которые нужны программе
# Не стоит их менять
var distance_passed = 0
# Типы положений
enum {DOWN, UP, LEFT, RIGHT}
# Текущий тип
var type = 0
# Стоял ли персонаж в предыдущий раз
# То есть задана ли уже неподвижная стойка
var idle = true
# Множитель, меняется при нажатии shift
var mult : int = 1
# Для порядка звуков шагов
var first_sound : bool = false
# Нажата ли хоть какая-нибудь кнопка передвижения
var any_button_pressed : bool
# Нажата ли кнопка влево или вправо
# Чтобы блокировать более позднюю обработку вверх и вниз
var side_used : bool
# Вектор передвижения
var velocity : Vector2
# Кадры
enum {DOWN_1, UP_1, SIDE_1,
	DOWN_2, UP_2, SIDE_2,
	DOWN_STILL, UP_STILL, SIDE_STILL}


# Заблокировать обработку ввода
func lock() -> void:
	set_physics_process(false)


# Возобновить обработку ввода
func unlock() -> void:
	set_physics_process(true)


# Воспроизвести звук шага
func play_step() -> void:
	if first_sound:
		player.play()
	else:
		player2.play()
	# Изменить состояние
	first_sound = !first_sound


# Общая часть функций движения в сторону
func go_side() -> void:
	idle = false
	side_used = true
	any_button_pressed = true
	distance_passed += 1
	# Анимация
	# Крайнее положение
	if distance_passed == change:
		character.frame = SIDE_2
		play_step()
	elif distance_passed == 2 * change:
		character.frame = SIDE_STILL
	# Крайнее положение
	elif distance_passed == 3 * change:
		character.frame = SIDE_1
		play_step()
	# Обратный порядок
	elif distance_passed == 4 * change:
		character.frame = SIDE_STILL
		distance_passed = 0


# Вправо
func go_right() -> void:
	if Input.is_action_pressed('ui_right'):
		# Если предыдущее состояние не "вправо"
		if type != RIGHT:
			type = RIGHT
			# Обнулить счетчик для анимации
			distance_passed = 0
			character.frame = SIDE_1
			character.flip_h = false
		go_side()
		velocity.x += 1


# Влево
func go_left() -> void:
	if Input.is_action_pressed('ui_left'):
		if type != LEFT:
			type = LEFT
			distance_passed = 0
			character.frame = 2
			character.flip_h = true
		go_side()
		velocity.x -= 1


# Вниз
func go_down() -> void:
	if Input.is_action_pressed('ui_down'):
		idle = false
		any_button_pressed = true
		if !side_used:
			if type != DOWN:
				type = DOWN
				distance_passed = 0
				character.frame = DOWN_1
				character.flip_h = false
			distance_passed += 1
			# Крайнее положение
			if distance_passed == change:
				character.frame = DOWN_1
				play_step()
			elif distance_passed == 3 * change:
				character.frame = DOWN_2
				play_step()
			elif distance_passed == 4 * change:
				distance_passed = DOWN_1 
		velocity.y += 1


# Вверх
func go_up() -> void:
	if Input.is_action_pressed('ui_up'):
		idle = false
		any_button_pressed = true
		if !side_used:
			if type != UP:
				type = UP
				distance_passed = 0
				character.frame = UP_1
				character.flip_h = false
			distance_passed += 1
			# Крайнее положение
			if distance_passed == change:
				character.frame = UP_1
				play_step()
			elif distance_passed == 3 * change:
				character.frame = UP_2
				play_step()
			elif distance_passed == 4 * change:
				distance_passed = UP_1
		velocity.y -= 1


# Обработка ввода
func get_input() -> bool:
	# Сбросить переменные
	velocity = Vector2()
	any_button_pressed = false
	side_used = false
	# Обработка 4 сторон передвижения
	go_right()
	go_left()
	go_down()
	go_up()
	# Если кнопки не были нажаты в первый раз
	if !idle && !any_button_pressed:
		idle = true
		if type == UP:
			character.frame = UP_STILL
		elif type == DOWN:
			character.frame = DOWN_STILL
		else:
			character.frame = SIDE_STILL
		return false
	mult = 2 if Input.is_action_pressed("speed_up") else 1
	velocity = velocity.normalized() * speed * mult
	return true


# Вызывается постоянно
func _physics_process(_delta) -> void:
	# Если была нажата хоть одна клавиша передвижения
	if get_input():
		# Переместиться на velocity
		# Он задается get_input() при обработке ввода
		move_and_slide(velocity)


func _ready() -> void:
	# Заставить интерфейс следовать за собой
	if has_node("/root/ui"):
		get_node("Character/Camera2D/RemoteTransform2D").remote_path = "/root/ui"
