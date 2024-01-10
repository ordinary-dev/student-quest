extends Control

# Displays messages on the screen
# and sets the title
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const MIN_DELAY := 1
const MAX_DELAY := 3

@export var title: String = "CHAT"
@export_file ("*.tscn") var next_scene_path
@export var messages: Array

var _message = load("res://scenes/templates/chat/message.tscn")
@onready var _container := $VBoxContainer/BodyBackground/Container
@onready var _header := $VBoxContainer/HeaderBackground/HeaderContainer/HeaderText


func next_scene() -> void:
	FX.play_btn_click()
	SCENES.load_scene(next_scene_path)


func _ready() -> void:
	_header.text = title
	for i in messages:
		var tmp = _message.instantiate()
		tmp.text = i
		_container.add_child(tmp)
		var delay := randf_range(MIN_DELAY, MAX_DELAY)
		await get_tree().create_timer(delay).timeout
