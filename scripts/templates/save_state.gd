extends Node2D

# Temporary save a value
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

export (String) var prop
export (String) var value


func _ready() -> void:
	STORAGE.save(prop, value)
