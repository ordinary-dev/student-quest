extends Node2D


# Инициализация интерфейса
func _ready() -> void:
	# Если нет игрока, то установить интерфейс в центре
	if !has_node("/root/Node2D/Body"):
		get_node("/root/ui").restore_default()
