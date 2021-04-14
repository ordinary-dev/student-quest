extends Node2D

# Enables and disables water
# splashes at the character's feet
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License


func _on_body_entered(_body) -> void:
	var player_path = STORAGE.get("player_path")
	assert(has_node(player_path))
	get_node(player_path).water.enable_water()


func _on_body_exited(_body) -> void:
	var player_path = STORAGE.get("player_path")
	assert(has_node(player_path))
	get_node(player_path).water.disable_water()
