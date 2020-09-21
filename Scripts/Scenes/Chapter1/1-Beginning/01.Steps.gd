# Steps script

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node2D

export (String, FILE, "*.tscn") var scene_path

onready var cam = $Camera2D
onready var tween = $Tween
onready var audio = $Step
var count = 0


func move() -> void:
	audio.play()
	if count < 2:
		var x = cam.position.x
		var y_pos = cam.position.y
		tween.interpolate_property(
			cam, "position",
			Vector2(x, y_pos), Vector2(x, y_pos-300),
			0.4, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		tween.interpolate_property(
			cam, "zoom",
			Vector2(0.55, 0.55), Vector2(0.6, 0.6),
			0.2, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		tween.interpolate_property(
			cam, "zoom",
			Vector2(0.6, 0.6), Vector2(0.55, 0.55),
			0.2, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 0.2)
		tween.start()
		count += 1
	else:
		SCENES.load_scene(scene_path)


func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		move()


func _ready() -> void:
	audio.play()
