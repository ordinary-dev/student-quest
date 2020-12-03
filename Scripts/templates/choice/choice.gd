extends Control

# Scene with a choice of actions
# You need to use another script
# to add options and specify the scene
# that will be loaded
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

const HEIGHT := 170
var _number_of_options := 0
var _btn_template = load("res://Scenes/templates/choice/option.tscn")
onready var _box := $VBoxContainer


func add_option(text: String, scene_path: String) -> void:
	_number_of_options += 1
	_box.rect_position = Vector2(560, 1080 - HEIGHT * _number_of_options)
	var tmp = _btn_template.instance()
	tmp.label = text
	tmp.connect("pressed", $"/root/SCENES", "load_scene", [scene_path])
	_box.add_child(tmp)
