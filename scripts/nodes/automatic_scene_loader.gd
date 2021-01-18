extends Node
class_name AutomaticSceneLoader

# Automatic scene loader
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.tscn") var next_scene
export (float, 0.0, 7.0) var delay = 0.0
export (bool) var transition_in = true
export (bool) var transition_out = true


func _ready() -> void:
	if delay > 0.0:
		yield(get_tree().create_timer(delay), "timeout")
	SCENES.load_scene(
			next_scene, transition_in, transition_out)
