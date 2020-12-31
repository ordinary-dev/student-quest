extends Area2D

# Shows text when the player
# approaches the trigger

const TIME := 0.3
const START_COLOR := Color(1, 1, 1, 0)
const END_COLOR := Color(1, 1, 1, 1)
export (String) var label = "Label"
onready var _tween := $Tween
onready var _frame := $Frame
onready var _label := $Frame/MarginContainer/Background/MarginContainer/Label


func show_ui() -> void:
	_frame.visible = true
	_tween.interpolate_property(_frame, "modulate",
		START_COLOR, END_COLOR, TIME, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	_tween.start()


func hide_ui() -> void:
	_tween.interpolate_property(_frame, "modulate",
		END_COLOR, START_COLOR, TIME, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	_tween.start()
	yield(get_tree().create_timer(TIME * 2), "timeout")
	_frame.visible = false


func _on_Area2D_body_entered(_body) -> void:
	show_ui()


func _on_Area2D_body_exited(_body) -> void:
	hide_ui()


func _ready() -> void:
	set_process(false)
	_frame.set_visible(false)
	_frame.modulate = START_COLOR
	_label.text = label
