extends Node

# Сцены паузы и управления
export (String, FILE, "*.tscn") var pause_scene = "res://Scenes/templates/pause.tscn"
export (String, FILE, "*.tscn") var contr_scene = "res://Scenes/templates/Controls.tscn"
# Принудительно включить джойстик
var SHOW_CONTROLS = false


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
func init() -> void:
	add_pause()
	if OS.get_name() == "Android" || SHOW_CONTROLS:
		add_controls()


# Удалить интерфейс
func disable() -> void:
	if has_node("/root/ui/Pause"):
		get_node("/root/ui").remove_child(get_node("/root/ui/Pause"))
	if has_node("/root/ui/Controls"):
		get_node("/root/ui").remove_child(get_node("/root/ui/Controls"))
