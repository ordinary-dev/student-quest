extends Control

export (NodePath) var label_path

var time = .05
var text_delay

onready var effect = $Tween
onready var mc = $MainContainer

const x_from := 550
const x_to := 600
const y_from := 150
const y_to := 200
const y_time := 0.15


func set_label(text : String) -> void:
	get_node(label_path).text = text
	text_delay = time*len(get_node(label_path).text)/2


func hide_self() -> void:
	hide_anim()
	yield(get_tree().create_timer(
		2*y_time + text_delay
	), "timeout")
	UI.get_node("Notifications").remove_child(self)


func hide_anim() -> void:
	effect.interpolate_property(
		get_node(label_path), "percent_visible",
		1, 0, text_delay,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	effect.interpolate_property(
		mc, "rect_size",
		Vector2(x_to, y_to), 
		Vector2(x_from, y_to), y_time,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 
		text_delay
	)
	effect.interpolate_property(
		mc, "rect_size",
		Vector2(x_from, y_to), 
		Vector2(x_from, y_from), y_time,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 
		text_delay + y_time
	)
	effect.start()


func start_anim() -> void:
	effect.interpolate_property(
		mc, "rect_size",
		Vector2(x_from, y_from), 
		Vector2(x_from, y_to), y_time,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT
	)
	effect.interpolate_property(
		mc, "rect_size",
		Vector2(x_from, y_to), 
		Vector2(x_to, y_to), y_time,
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT, y_time
	)
	effect.interpolate_property(
		get_node(label_path), "percent_visible",
		0, 1, text_delay,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 2*y_time)
	effect.start()
	yield(get_tree().create_timer(
		text_delay + 2*y_time + 1
	), "timeout")
	hide_self()


func _ready() -> void:
	get_node(label_path).percent_visible = 0
