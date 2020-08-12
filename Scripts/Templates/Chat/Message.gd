# Message

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Control

export (String) var text


func _ready() -> void:
	$Background/MarginContainer/MessageText.text = text
