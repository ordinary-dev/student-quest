# Train window

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node2D

export(String, FILE, "*.tscn") var next_scene

onready var audio := $TrainSound

const delay = 4


func _ready() -> void:
	audio.play()
	audio.seek(7)
	yield(get_tree().create_timer(delay), "timeout")
	load_scene()


func load_scene() -> void:
	SCENES.load_scene(next_scene)
