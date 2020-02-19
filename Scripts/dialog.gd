extends Node

var dialog_scene : = load("res://Scenes/dialog.tscn")

func hide_dialog():
	get_node("/root/Node2D/Position2D").remove_child(get_node("/root/Node2D/Position2D/dialog"))

func show_next(content : Dictionary, key : String) -> void:
	var name : = get_node("/root/Node2D/Position2D/dialog/Dialog/Main/Margin/HBox/VBox/Name")
	var text : = get_node("/root/Node2D/Position2D/dialog/Dialog/Main/Margin/HBox/VBox/Text")
	var btn : = get_node("/root/Node2D/Position2D/dialog/Dialog/Main/Margin/HBox/Button")
	text.percent_visible = 0
	name.text = content[key]["name"]
	text.text = content[key]["text"]
	if content[key].has("next"):
		key = content[key]["next"]
		btn.disconnect("pressed", self, "show_next")
		btn.connect("pressed", self, "show_next", [content, key])
	else:
		key = "-1"
		btn.disconnect("pressed", self, "show_next")
		btn.connect("pressed", self, "hide_dialog")
	get_node("/root/Node2D/Position2D/dialog/AnimationPlayer").play("text")
	

func show_dialog(num : int) -> void:
	if has_node("/root/Node2D"):
		# Подготовить интерфейс
		var nd : = get_node("/root/Node2D/Position2D")
		var tmp = dialog_scene.instance()
		tmp.name = "dialog"
		nd.add_child(tmp)
		# Открыть файл
		var fl : = File.new()
		fl.open("res://Dialogs/" + str(num) + ".tres", File.READ)
		var content = parse_json(fl.get_as_text())
		fl.close()
		# Показать диалог
		show_next(content, "0")
		
