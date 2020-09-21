extends Control

export (String) var title = "CHAT"
export (String, FILE, "*.tscn") var next_scene_path
export (Array, String) var messages

var message = load("res://Scenes/Templates/Chat/Message.tscn")

onready var cont   = $VBoxContainer/BodyBackground/Container
onready var header = $VBoxContainer/HeaderBackground/HeaderContainer/HeaderText

const min_delay := 1
const max_delay := 3


func next_scene() -> void:
	FX.btn_click()
	SCENES.load_scene(next_scene_path)


func add_message(text : String) -> void:
	var tmp = message.instance()
	tmp.text = text
	cont.add_child(tmp)


func _ready() -> void:
	header.text = title
	for i in messages:
		add_message(i)
		var delay := rand_range(min_delay, max_delay)
		yield(get_tree().create_timer(delay), "timeout")
