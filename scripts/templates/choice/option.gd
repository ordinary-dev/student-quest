extends Button

# This button is used in a different scene
# to select one of the options
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

export (String) var label setget _set_label


func _set_label(val: String) -> void:
	label = val
	$ColorRect/Label.text = label
