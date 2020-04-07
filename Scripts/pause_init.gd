extends Node

# Сцены паузы и управления
const pause_scene = "res://Scenes/ui/Pause.tscn"
const contr_scene = "res://Scenes/ui/Controls.tscn"
const time_scene = "res://Scenes/ui/Time.tscn"
# Принудительно включить джойстик
const SHOW_CONTROLS = false
const ui_base = "/root/ui/CanvasLayer"


# Добавить кнопку паузы
func add_pause() -> void:
	var sc = load(pause_scene).instance()
	sc.name = "Pause"
	get_node(ui_base).add_child(sc)


# Добавить управление
func add_controls() -> void:
	var sc = load(contr_scene).instance()
	sc.name = "Controls"
	get_node(ui_base).add_child(sc)


# Добавить интерфейс времени
func show_time(time) -> void:
	if !has_node(ui_base + "/Time"):
		var time_obj = load(time_scene).instance()
		time_obj.name = "Time"
		get_node(ui_base).add_child(time_obj)
		get_node(ui_base + "/Time").set_time(time)
		get_node(ui_base + "/Time").start()


# Скрыть время
func hide_time() -> void:
	if has_node(ui_base + "/Time"):
		get_node(ui_base + "/Time").stop()
		get_node(ui_base).remove_child(get_node(ui_base + "/Time"))


# Создать интерфейс
func enable_ui() -> void:
	if !has_node(ui_base + "/Pause"):
		add_pause()
	if OS.get_name() == "Android" or SHOW_CONTROLS:
		if !has_node(ui_base + "/Controls"):
			add_controls()


# Удалить интерфейс
func disable_ui() -> void:
	if has_node(ui_base + "/Pause"):
		get_node(ui_base).remove_child(get_node(ui_base + "/Pause"))
	if has_node(ui_base + "/Controls"):
		get_node(ui_base).remove_child(get_node(ui_base + "/Controls"))

