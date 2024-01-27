extends Control

@export var label_path: NodePath

var time = .05
var text_delay


@onready var mc = $MainContainer

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
	await get_tree().create_timer(2*y_time + text_delay).timeout
	UI.get_node("Notifications").remove_child(self)


func hide_anim() -> void:
	var tween = create_tween()
	tween.tween_property(
		get_node(label_path), "visible_ratio", 0.0, text_delay,
	).from(1.0)
	tween.tween_property(
		mc, "size", Vector2(x_from, y_to), y_time,
	).from(Vector2(x_to, y_to))
	tween.tween_property(
		mc, "size", Vector2(x_from, y_from), y_time,
	).from(Vector2(x_from, y_to))


func start_anim() -> void:
	var tween = create_tween()
	tween.tween_property(
		mc, "size", Vector2(x_from, y_to), y_time,
	).from(Vector2(x_from, y_from))
	tween.tween_property(
		mc, "size", Vector2(x_to, y_to), y_time,
	).from(Vector2(x_from, y_to))
	tween.tween_property(
		get_node(label_path), "visible_ratio", 1.0, text_delay,
	).from(0.0)
	await get_tree().create_timer(text_delay + 2*y_time + 1).timeout
	hide_self()


func _ready() -> void:
	get_node(label_path).visible_ratio = 0.0
