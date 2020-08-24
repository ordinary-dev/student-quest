# Load scene

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Area2D

export (String) var label = "Load Scene"
export (String, FILE, "*.tscn") var scene_path

onready var tween = $Tween
onready var main_frame = $MainFrame
onready var btn_frame = $ButtonHintFrame
onready var btn = $Button
onready var label_obj = $MainFrame/Container/Background/TextContainer/Text

const start := Color(1, 1, 1, 0)
const end   := Color(1, 1, 1, 1)
const time : float = 0.3

var button_pressed := false


func _process(_delta) -> void:
	if Input.is_action_pressed("dialog_start") or button_pressed:
		button_pressed = false
		SCENES.load_scene(scene_path)
		hide_ui()
		set_process(false)


func show_ui() -> void:
	main_frame.visible = true
	btn_frame.visible = true
	btn.visible = true
	tween.interpolate_property(main_frame, "modulate",
		start, end, time, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.interpolate_property(btn_frame, "modulate",
		start, end, time, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
	

func hide_ui() -> void:
	btn.visible = false
	tween.interpolate_property(main_frame, "modulate",
		end, start, time, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.interpolate_property(btn_frame, "modulate",
		end, start, time, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
	yield(get_tree().create_timer(time*2), "timeout")
	main_frame.visible = false
	btn_frame.visible = false


func _on_Area2D_body_entered(_body) -> void:
	show_ui()
	set_process(true)


func _on_Area2D_body_exited(_body) -> void:
	hide_ui()
	set_process(false)


func _ready() -> void:
	main_frame.set_visible(false)
	btn_frame.set_visible(false)
	btn.set_visible(false)
	label_obj.text = label
	set_process(false)
	main_frame.modulate = start
	btn_frame.modulate = start


func _on_Button_pressed() -> void:
	button_pressed = true
