extends Control

# Changes the time on the screen,
# then loads the next scene
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const TIME := ["0:00", "6:00", "12:00", "18:00"]
const REPEAT := 3
const DELAY := 0.3
export (String, FILE, "*.tscn") var next_scene
onready var _label := $Label


func _ready() -> void:
	for _j in range(REPEAT):
		for i in TIME:
			_label.text = i
			yield(get_tree().create_timer(DELAY), "timeout")
	SCENES.load_scene(next_scene)
