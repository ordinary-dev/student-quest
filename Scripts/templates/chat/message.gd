extends Control

# Sets the message text
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

export (String) var text
onready var _label = $Background/MarginContainer/MessageText


func _ready() -> void:
	_label.text = text
