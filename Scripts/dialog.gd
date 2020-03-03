extends Node

var dialog_scene : = load("res://Scenes/templates/dialog.tscn")
var effect
var s_content : Dictionary
var s_key : String

# Опционально вызвать функцию fnc у объекта obj
var glob_obj:String
var glob_fnc:String

func hide_dialog():
	get_node("/root/ui").remove_child(get_node("/root/ui/dialog"))
	set_process(false)
	# Разблокировать персонажа
	if has_node("/root/Node2D/Body"):
		get_node("/root/Node2D/Body").unlock()
	# Отправить сигнал
	# Нужен некоторым скриптам для того,
	# Чтобы продолжить сразу после диалога
	if has_node(glob_obj):
		get_node(glob_obj).call(glob_fnc)
	glob_obj = ""

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if s_key != "-1":
			show_next()
		else:
			hide_dialog()

func show_next() -> void:
	var name : = get_node("/root/ui/dialog/Dialog/Main/Margin/HBox/VBox/Name")
	var text : = get_node("/root/ui/dialog/Dialog/Main/Margin/HBox/VBox/Text")
	var btn : = get_node("/root/ui/dialog/Dialog/Main/Margin/HBox/Button")
	text.percent_visible = 0
	name.text = s_content[s_key]["name"]
	text.text = s_content[s_key]["text"]
	if s_content[s_key].has("next"):
		s_key = s_content[s_key]["next"]
		btn.disconnect("pressed", self, "show_next")
		btn.connect("pressed", self, "show_next")
	else:
		s_key = "-1"
		btn.disconnect("pressed", self, "show_next")
		btn.connect("pressed", self, "hide_dialog")
	effect.interpolate_property(text, "percent_visible", 0, 1, len(text.text) / 30.0, Tween.TRANS_LINEAR)
	effect.start()
	

func show_dialog(num : int, obj:String = "", fnc:String = "") -> void:
	# Сохранить значения
	glob_obj = obj
	glob_fnc = fnc
	# Подготовить интерфейс
	var nd : = get_node("/root/ui")
	var tmp = dialog_scene.instance()
	tmp.name = "dialog"
	nd.add_child(tmp)
	# Открыть файл
	var fl : = File.new()
	fl.open("res://Dialogs/" + str(num) + ".tres", File.READ)
	var content = parse_json(fl.get_as_text())
	fl.close()
	# Найти Tween
	effect = get_node("/root/ui/dialog/Tween")
	# Активировать отслеживание кнопки
	set_process(true)
	# Сохранить значения
	s_content = content
	s_key = "0"
	# Заблокировать персонажа
	if has_node("/root/Node2D/Body"):
		get_node("/root/Node2D/Body").lock()
	# Показать диалог
	show_next()
		
func _ready():
	set_process(false)
