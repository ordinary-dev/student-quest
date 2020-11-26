# The script to quit the game

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Control


func _ready():
	# Save data
	SETTINGS.write_settings()
	# Quit
	get_tree().quit()
