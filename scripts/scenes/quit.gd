extends Control

# The script to quit the game
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License


func _ready() -> void:
	# Save data
	SETTINGS.write_settings()
	# Quit
	get_tree().quit()
