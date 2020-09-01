# Hide dialog

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node2D


func _ready():
	if DIALOG.is_shown:
		DIALOG.hide_dialog()
