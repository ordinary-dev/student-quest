extends Control

# Displays messages on the screen
# and sets the title
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

const MIN_DELAY := 1
const MAX_DELAY := 3

export (String) var title = "CHAT"
export (String, FILE, "*.tscn") var next_scene_path
export (Array, String) var messages

var _message = load("res://Scenes/templates/chat/message.tscn")
onready var _container := $VBoxContainer/BodyBackground/Container
onready var _header := $VBoxContainer/HeaderBackground/HeaderContainer/HeaderText


func next_scene() -> void:
	FX.play_btn_click()
	SCENES.load_scene(next_scene_path)


func _ready() -> void:
	_header.text = title
	for i in messages:
		var tmp = _message.instance()
		tmp.text = i
		_container.add_child(tmp)
		var delay := rand_range(MIN_DELAY, MAX_DELAY)
		yield(get_tree().create_timer(delay), "timeout")
