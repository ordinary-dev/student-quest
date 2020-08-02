# Loading script

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends Control

export (String, FILE, "*.tscn") var menu_scene_path
export (String, FILE, "*.tscn") var alternate_scene_path

onready var loading_text := $LoadingText
onready var audio_src = $Click

const delay : float = 0.7


func _ready() -> void:
	if GLOBAL.first_run:
		# Running for the first time
		# Cache translation
		var message := tr(loading_text.text)
		# Add dots at the end
		for i in range(3):
			yield(get_tree().create_timer(delay), "timeout")
			loading_text.text = message + ".".repeat(i + 1)
			# Play random sound
			audio_src.play()
		# Load alternate scene
		yield(get_tree().create_timer(delay), "timeout")
		SCENES.load_scene(alternate_scene_path)
	else:
		# Normal start
		SCENES.load_scene(menu_scene_path)
