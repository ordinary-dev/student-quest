# Message

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Control

export (String) var text


func _ready() -> void:
	$Background/MarginContainer/MessageText.text = text
