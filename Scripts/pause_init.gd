extends Node

# Сцены паузы и управления
export (String, FILE, "*.tscn") var pause_scene = "res://Scenes/ui/Pause.tscn"
export (String, FILE, "*.tscn") var contr_scene = "res://Scenes/ui/Controls.tscn"
# Принудительно включить джойстик
const SHOW_CONTROLS = false


# Добавить кнопку паузы
func add_pause() -> void:
	var sc = load(pause_scene).instance()
	sc.name = "Pause"
	get_node("/root/ui").add_child(sc)


# Добавить управление
func add_controls() -> void:
	var sc = load(contr_scene).instance()
	sc.name = "Controls"
	get_node("/root/ui").add_child(sc)


# Создать интерфейс
func enable_ui() -> void:
	if !has_node("/root/ui/Pause"):
		add_pause()
	if OS.get_name() == "Android" or SHOW_CONTROLS:
		if !has_node("/root/ui/Controls"):
			add_controls()


# Удалить интерфейс
func disable_ui() -> void:
	if has_node("/root/ui/Pause"):
		get_node("/root/ui").remove_child(get_node("/root/ui/Pause"))
	if has_node("/root/ui/Controls"):
		get_node("/root/ui").remove_child(get_node("/root/ui/Controls"))
