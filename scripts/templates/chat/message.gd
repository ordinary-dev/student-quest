extends Control

# Sets the message text
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export var text: String
@onready var _label = $Background/MarginContainer/MessageText


func _ready() -> void:
	_label.text = text
