# Temporary save a value

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node2D

export (String) var prop
export (String) var value


func _ready() -> void:
	TEMP.save(prop, value)
