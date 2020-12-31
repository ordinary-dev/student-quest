extends Node2D

# Disables water splashing
# when the player is on the bridge


func _on_body_entered(_body) -> void:
	var player_path = STORAGE.get("player_path")
	if has_node(player_path):
		get_node(player_path).water.hide_water = true


func _on_body_exited(_body) -> void:
	var player_path = STORAGE.get("player_path")
	if has_node(player_path):
		get_node(player_path).water.hide_water = false
