# Train window

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

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
