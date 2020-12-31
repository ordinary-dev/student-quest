extends Node2D

# Turns off the light and loads the scene

const START_COLOR := Color("#ffffff")
const END_COLOR := Color("#2d2d2d")
const DELAY_BEFORE := 1
const ANIM_DURATION := 1
const DELAY_AFTER := 2
export(String, FILE, "*.tscn") var scene_path
onready var _tween = $Tween
onready var _canvas = $CanvasModulate


func _ready() -> void:
	yield(get_tree().create_timer(DELAY_BEFORE), "timeout")
	_tween.interpolate_property(
		_canvas, "color",
		START_COLOR, END_COLOR, ANIM_DURATION,
		Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT
		)
	_tween.start()
	yield(get_tree().create_timer(DELAY_AFTER), "timeout")
	SCENES.load_scene(scene_path, false, false)
