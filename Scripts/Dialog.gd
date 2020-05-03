extends Node


var dialog_scene : = load("res://Scenes/templates/Dialog.tscn")
var s_content : Dictionary
var s_key : String

# Опционально вызвать функцию fnc у объекта obj
var call_after:bool
var glob_obj:String
var glob_fnc:String
var glob_argv:String

# Нужно ли вернуть интерфейс
var return_ui : bool


func hide_dialog():
	var dialog_obj = UI.get_node("dialog")
	dialog_obj.play_reverse()
	yield(get_tree().create_timer(dialog_obj.shape_time), "timeout")
	UI.remove_child(dialog_obj)
	set_process(false)
	# Разблокировать персонажа
	if has_node("/root/Node2D/Body"):
		get_node("/root/Node2D/Body").unlock()
	# Отправить сигнал
	# Нужен некоторым скриптам для того,
	# Чтобы продолжить сразу после диалога
	if call_after and has_node(glob_obj):
		if glob_argv == "":
			get_node(glob_obj).call(glob_fnc)
		else:
			get_node(glob_obj).call(glob_fnc, glob_argv)
	glob_obj = ""
	if return_ui:
		UI_INIT.enable_ui()


func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if s_key != "-1":
			show_next()
		else:
			hide_dialog()


func show_next() -> void:
	var dial = UI.get_node("dialog")
	dial.play_dialog(
		s_content[s_key]["name"],
		tr(s_content[s_key]["text"])
	)
	var btn = UI.get_node("dialog/" + dial.next_button)
	if s_content[s_key].has("next"):
		s_key = s_content[s_key]["next"]
		btn.disconnect("pressed", self, "show_next")
		btn.connect("pressed", self, "show_next")
	else:
		if s_key != "0":
			btn.disconnect("pressed", self, "show_next")
		s_key = "-1"
		btn.connect("pressed", self, "hide_dialog")


func show_dialog(path:String, obj:String = "", fnc:String = "", argv:String="") -> void:
	# Открыть файл
	var fl : = File.new()
	var state : = fl.open(path, File.READ)
	if (state != OK):
		NOTIFY.show("Не могу загрузить диалог")
		return
	# Заблокировать персонажа
	if has_node("/root/Node2D/Body"):
		get_node("/root/Node2D/Body").lock()
	if UI.get_node("Pause").visible:
		UI_INIT.disable_ui()
		return_ui = true
	else:
		return_ui = false
	# Звук
	FX.dialog()
	
	# Сохранить значения
	if obj != "":
		call_after = true
		glob_obj = obj
		glob_fnc = fnc
		glob_argv = argv
	else:
		call_after = false
	
	# Подготовить интерфейс
	var tmp = dialog_scene.instance()
	tmp.name = "dialog"
	UI.add_child(tmp)
	# Прочитать файл
	var content = parse_json(fl.get_as_text())
	fl.close()
	# Активировать отслеживание кнопки
	set_process(true)
	# Сохранить значения
	s_content = content
	s_key = "0"
	# Показать диалог
	show_next()


func _ready():
	set_process(false)
