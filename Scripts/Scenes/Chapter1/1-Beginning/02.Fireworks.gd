# Fireworks

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node2D

export (String, FILE, "*.tscn") var next_scene


func _on_animation_finished(_anim_name) -> void:
	SCENES.load_scene(next_scene)
