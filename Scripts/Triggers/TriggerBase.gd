# Trigger base class

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Area2D

export (String) var hint = "Trigger"

onready var tween  = $TriggerBase/Tween
onready var frame1 = $TriggerBase/DialogFrame
onready var frame2 = $TriggerBase/ButtonHintFrame
onready var btn    = $TriggerBase/DialogButton
onready var label  = $TriggerBase/DialogFrame/Container/DialogBackground/TextContainer/TextLabel

const start := Color(1, 1, 1, 0)
const end   := Color(1, 1, 1, 1)
const time : float = 0.3

export (bool) var use_once = true
var used = false
var button_pressed = false
var action : FuncRef


func _process(_delta) -> void:
	if Input.is_action_pressed("dialog_start") or button_pressed:
		button_pressed = false
		action.call_func()
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
	if !used or !use_once:
		show_ui()
		set_process(true)


func _on_Area2D_body_exited(_body) -> void:
	if !used or !use_once:
		hide_ui()
		set_process(false)


func _ready() -> void:
	frame1.visible = false
	frame2.visible = false
	btn.visible = false
	btn.connect("pressed", self, "_on_Button_pressed")
	label.text = hint
	set_process(false)
	frame1.modulate = start
	frame2.modulate = start


func _on_Button_pressed() -> void:
	button_pressed = true
