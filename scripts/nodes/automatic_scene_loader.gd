extends Node
class_name AutomaticSceneLoader

# Automatic scene loader
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export_file("*.tscn") var next_scene
@export_range(0.0, 7.0) var delay: float = 0.0
@export var transition_in: bool = true
@export var transition_out: bool = true


func _ready() -> void:
	if delay > 0.0:
		await get_tree().create_timer(delay).timeout
	SCENES.load_scene(
			next_scene, transition_in, transition_out)
