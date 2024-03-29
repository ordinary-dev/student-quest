extends Node2D

# Plays the train sound and loads the next scene
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const DELAY := 3
@export_file("*.tscn") var next_scene
@onready var _audio := $TrainSound


func _ready() -> void:
	_audio.play(7)
	await get_tree().create_timer(DELAY).timeout
	SCENES.load_scene(next_scene)
