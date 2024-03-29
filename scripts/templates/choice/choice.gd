extends Control

# Scene with a choice of actions
# You need to use another script
# to add options and specify the scene
# that will be loaded
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const HEIGHT := 170
var _number_of_options := 0
var _btn_template = load("res://scenes/templates/choice/option.tscn")
@onready var _box := $VBoxContainer


func add_option(text: String, scene_path: String) -> void:
	_number_of_options += 1
	_box.position = Vector2(560, 1080 - HEIGHT * _number_of_options)
	var tmp = _btn_template.instantiate()
	tmp.label = text
	tmp.connect("pressed", Callable($"/root/SCENES", "load_scene").bind(scene_path))
	_box.add_child(tmp)
