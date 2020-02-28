extends Node2D


# Нажатие ESC
func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_node("/root/ui/Pause").switch()


# Инициализация интерфейса
func _ready() -> void:
	# Если нет игрока, то установить интерфейс в центре
	if !has_node("/root/Node2D/Body"):
		get_node("/root/ui").restore_default()
	# Появление паузы и джойстика на мобильных платформах
	get_node("/root/pause_init").init()
