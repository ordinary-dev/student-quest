extends Node

var dialog_scene : = load("res://Scenes/templates/dialog.tscn")
var s_content : Dictionary
var s_key : String

# Опционально вызвать функцию fnc у объекта obj
var glob_obj:String
var glob_fnc:String
var glob_argv:String

# Нужно ли вернуть интерфейс
var return_ui : bool

func hide_dialog():
	get_node("/root/ui/dialog").play_reverse()
	yield(get_tree().create_timer(
		get_node("/root/ui/dialog").shape_time
	), "timeout")
	get_node("/root/ui").remove_child(get_node("/root/ui/dialog"))
	set_process(false)
	# Разблокировать персонажа
	if has_node("/root/Node2D/Body"):
		get_node("/root/Node2D/Body").unlock()
	# Отправить сигнал
	# Нужен некоторым скриптам для того,
	# Чтобы продолжить сразу после диалога
	if has_node(glob_obj):
		if glob_argv == "":
			get_node(glob_obj).call(glob_fnc)
		else:
			get_node(glob_obj).call(glob_fnc, glob_argv)
	else:
		get_node("/root/show_nf").show_notification("No such object: " + glob_obj)
	glob_obj = ""
	if return_ui:
		get_node("/root/pause_init").enable_ui()

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if s_key != "-1":
			show_next()
		else:
			hide_dialog()

func show_next() -> void:
	var dial = get_node("/root/ui/dialog")
	dial.play_dialog(
		s_content[s_key]["name"],
		s_content[s_key]["text"]
	)
	var btn = get_node("/root/ui/dialog/" + dial.next_button)
	if s_content[s_key].has("next"):
		s_key = s_content[s_key]["next"]
		btn.disconnect("pressed", self, "show_next")
		btn.connect("pressed", self, "show_next")
	else:
		s_key = "-1"
		btn.disconnect("pressed", self, "show_next")
		btn.connect("pressed", self, "hide_dialog")


func show_dialog(num : int, obj:String = "", fnc:String = "", argv:String="") -> void:
	if has_node("/root/ui/Pause"):
		get_node("/root/pause_init").disable_ui()
		return_ui = true
	else:
		return_ui = false
	# Звук
	get_node("/root/fx").dialog()
	# Сохранить значения
	glob_obj = obj
	glob_fnc = fnc
	glob_argv = argv
	
	# Открыть файл
	var fl : = File.new()
	var state : = fl.open("res://Dialogs/" + str(num) + ".tres", File.READ)
	if (state == OK):
		# Подготовить интерфейс
		var nd : = get_node("/root/ui")
		var tmp = dialog_scene.instance()
		tmp.name = "dialog"
		nd.add_child(tmp)
		# Прочитать файл
		var content = parse_json(fl.get_as_text())
		fl.close()
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
	else:
		get_node("/root/show_nf").show_notification("Не могу загрузить диалог")
		
func _ready():
	set_process(false)
