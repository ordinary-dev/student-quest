# Unlock stage

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node

export (int) var subchapter_id = 1


func _ready() -> void:
	if GLOBAL.progress < subchapter_id:
		GLOBAL.progress = subchapter_id
		GLOBAL.write_settings()
