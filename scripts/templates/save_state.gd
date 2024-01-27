extends Node2D

# Temporary save a value
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export var prop: String
@export var value: String


func _ready() -> void:
	STORAGE.save(prop, value)
