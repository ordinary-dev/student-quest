extends Node2D

# Turns off the light and loads the scene

const START_COLOR := Color("#ffffff")
const END_COLOR := Color("#2d2d2d")
const DELAY_BEFORE := 1
const ANIM_DURATION := 1
const DELAY_AFTER := 2
@export_file("*.tscn") var scene_path
@onready var _canvas = $CanvasModulate


func _ready() -> void:
	var tween = create_tween()
	await get_tree().create_timer(DELAY_BEFORE).timeout
	tween.tween_property(_canvas, "color", END_COLOR, ANIM_DURATION).from(START_COLOR)
	await get_tree().create_timer(DELAY_AFTER).timeout
	SCENES.load_scene(scene_path, false, false)
