# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node2D

export (bool) var show_neo = false
onready var neo = $YSort/Neo


func _ready() -> void:
	if !show_neo:
		neo.queue_free()
