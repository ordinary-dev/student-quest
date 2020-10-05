# Change time

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Control

export (String, FILE, "*.tscn") var next_scene

onready var label = $Label

const time = ["0:00", "6:00", "12:00", "18:00"]
const repeat := 3
const delay := 0.3


func _ready() -> void:
	for _j in range(repeat):
		for i in time:
			label.text = i
			yield(get_tree().create_timer(delay), "timeout")
	SCENES.load_scene(next_scene)
