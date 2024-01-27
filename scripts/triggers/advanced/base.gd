extends Area2D

# Trigger base class
# All inherited classes must override the "action" method!
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const START_COLOR := Color(1, 1, 1, 0)
const END_COLOR   := Color(1, 1, 1, 1)
const TIME: float = 0.3

@export var hint: String = "Trigger"
@export var use_once: bool = true

var _used = false
var _button_pressed = false

@onready var _frame1 = $TriggerBase/DialogFrame
@onready var _frame2 = $TriggerBase/ButtonHintFrame
@onready var _btn    = $TriggerBase/DialogButton
@onready var _label  = $TriggerBase/DialogFrame/Container/DialogBackground/TextContainer/TextLabel


# Do not forget to override this method
func action() -> void:
	pass


func _ready() -> void:
	# Hide elements
	_frame1.modulate = START_COLOR
	_frame2.modulate = START_COLOR
	_frame1.visible = false
	_frame2.visible = false
	_btn.visible = false
	# Connect action
	_btn.connect("pressed", Callable(self, "_on_Button_pressed"))
	# Set label
	_label.text = hint
	# Do not process actions
	set_process(false)


func _process(_delta) -> void:
	if Input.is_action_pressed("dialog_start") or _button_pressed:
		_button_pressed = false
		action()
		_hide_ui()
		_used = true
		set_process(false)


func _show_ui() -> void:
	_btn.visible = true
	_frame1.visible = true
	_frame2.visible = true
	var tween = create_tween()
	if tween == null:
		return
	tween.tween_property(_frame1, "modulate", END_COLOR, TIME).from(START_COLOR)
	tween.parallel().tween_property(_frame2, "modulate", END_COLOR, TIME).from(START_COLOR)


func _hide_ui() -> void:
	var tween = create_tween()
	if tween == null:
		return
	tween.tween_property(_frame1, "modulate", START_COLOR, TIME).from(END_COLOR)
	tween.parallel().tween_property(_frame2, "modulate", START_COLOR, TIME).from(END_COLOR)
	await get_tree().create_timer(TIME*2).timeout
	_frame1.visible = false
	_frame2.visible = false
	_btn.visible = false


func _on_Area2D_body_entered(_body) -> void:
	if !_used or !use_once:
		_show_ui()
		set_process(true)


func _on_Area2D_body_exited(_body) -> void:
	if !_used or !use_once:
		_hide_ui()
		set_process(false)


func _on_Button_pressed() -> void:
	_button_pressed = true
