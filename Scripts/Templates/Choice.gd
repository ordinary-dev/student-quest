# Choice script

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Control

var btn_template = load("res://Scenes/Templates/Choice/Option.tscn")
var options := 0

onready var box := $VBoxContainer

const height := 170


func add_option(text:String, scene_path:String) -> void:
	options += 1
	box.rect_position = Vector2(560, 1080-height*options)
	var tmp = btn_template.instance()
	tmp.label = text
	tmp.connect("pressed", $"/root/SCENES", "load_scene", [scene_path])
	box.add_child(tmp)
