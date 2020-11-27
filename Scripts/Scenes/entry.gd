extends Control

# Loading script
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

const DELAY := 0.7
export (String, FILE, "*.tscn") var menu_scene_path
export (String, FILE, "*.tscn") var alternate_scene_path
onready var _loading_text := $LoadingText
onready var _audio_src := $Click


func _ready() -> void:
	if not SETTINGS.is_file_exist():
		# Running for the first time
		# Cache translation
		var message := tr(_loading_text.text)
		# Add dots at the end
		for i in range(3):
			yield(get_tree().create_timer(DELAY), "timeout")
			_loading_text.text = message + ".".repeat(i + 1)
			# Play random sound
			_audio_src.play()
		# Load alternate scene
		yield(get_tree().create_timer(DELAY), "timeout")
		SCENES.load_scene(alternate_scene_path)
	else:
		# Normal start
		SCENES.load_scene(menu_scene_path)
