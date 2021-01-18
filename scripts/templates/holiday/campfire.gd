tool
extends AnimatedSprite

# Controls the campfire and its sounds
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const AUDIO_SOURCE_PATH := "AudioStreamPlayer2D"
const COLLIDER_PATH := "StaticBody2D/CollisionShape2D"
export (bool) var enabled = true setget _set_fire_visibility


func _set_fire_visibility(val: bool) -> void:
	enabled = val
	visible = enabled
	# Disable collider
	var col := get_node(COLLIDER_PATH)
	col.disabled = not enabled


func _ready() -> void:
	if not Engine.editor_hint and enabled:
		# Play sound
		if has_node(AUDIO_SOURCE_PATH):
			var player := get_node(AUDIO_SOURCE_PATH)
			player.play()
		# Play animation
		play()
