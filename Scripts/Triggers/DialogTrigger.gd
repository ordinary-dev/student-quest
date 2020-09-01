# Dialog trigger

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Area2D

export (String, FILE, "*.json") var dialog_path
export (String) var person = "Mr. Human"
export (bool) var load_scene = false
export (String, FILE, "*.tscn") var scene_path

onready var tween = $Tween
onready var frame1 = $DialogFrame
onready var frame2 = $ButtonHintFrame
onready var btn = $DialogButton
onready var label = $DialogFrame/Container/DialogBackground/TextContainer/TextLabel

const start := Color(1, 1, 1, 0)
const end   := Color(1, 1, 1, 1)
const time : float = 0.3

var used = false
var button_pressed = false


func _process(_delta) -> void:
	if Input.is_action_pressed("dialog_start") or button_pressed:
		button_pressed = false
		if load_scene:
			DIALOG.show_dialog(dialog_path, "/root/SCENES", "load_scene", scene_path)
		else:
			DIALOG.show_dialog(dialog_path)
		hide_ui()
		used = true
		set_process(false)


func show_ui() -> void:
	btn.visible = true
	frame1.visible = true
	frame2.visible = true
	tween.interpolate_property(frame1, "modulate",
		start, end, time, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.interpolate_property(frame2, "modulate",
		start, end, time,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()


func hide_ui() -> void:
	tween.interpolate_property(frame1, "modulate",
		end, start, time, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.interpolate_property(frame2, "modulate",
		end, start, time, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
	yield(get_tree().create_timer(time*2), "timeout")
	frame1.visible = false
	frame2.visible = false
	btn.visible = false


func _on_Area2D_body_entered(_body) -> void:
	if !used:
		show_ui()
		set_process(true)


func _on_Area2D_body_exited(_body) -> void:
	if !used:
		hide_ui()
		set_process(false)


func _ready() -> void:
	frame1.visible = false
	frame2.visible = false
	btn.visible = false
	label.text = person
	set_process(false)
	frame1.modulate = start
	frame2.modulate = start


func _on_Button_pressed() -> void:
	button_pressed = true
