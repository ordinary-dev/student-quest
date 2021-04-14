extends MarginContainer

# Graphics settings
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

onready var vsync_btn := $Buttons/VSync
onready var fullscreen_btn := $Buttons/Fullscreen


func toggle_fullscreen_mode(state: bool) -> void:
	OS.window_fullscreen = state


func toggle_vsync_mode(state: bool) -> void:
	OS.vsync_enabled = state


# Update interface
func _ready() -> void:
	vsync_btn.pressed = OS.vsync_enabled
	fullscreen_btn.pressed = OS.window_fullscreen
