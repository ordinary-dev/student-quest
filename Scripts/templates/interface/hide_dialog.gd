extends Node2D

# Hide dialog
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License


func _ready() -> void:
	if DIALOG.is_shown:
		DIALOG.hide_dialog()
