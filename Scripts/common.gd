extends Node2D


# Нажатие ESC
func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_node("Position2D/Pause").switch()


# Инициализация интерфейса
func _ready() -> void:
	# Родитель для UI
	var pos = Position2D.new()
	pos.name = "Position2D"
	add_child(pos)
	# Передача координат игрока
	get_node("Body/Character/Camera2D/RemoteTransform2D").remote_path = "/root/Node2D/Position2D"
	# Появление паузы и джойстика на мобильных платформах
	get_node("/root/pause_init").init()
