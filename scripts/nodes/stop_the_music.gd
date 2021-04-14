extends Node
class_name StopTheMusic

# Stops music on scene loading
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License


func _ready():
	MUSIC.stop()
