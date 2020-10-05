# Graphics settings

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends MarginContainer

export(NodePath) var vsync_btn_path
export(NodePath) var fullscreen_btn_path

var vsync_btn : CheckButton
var fullscreen_btn : CheckButton


func toggle_fullscreen_mode(state : bool) -> void:
	OS.window_fullscreen = state


func toggle_vsync_mode(state : bool) -> void:
	OS.vsync_enabled = state


# Update interface
func _ready() -> void:
	vsync_btn = get_node(vsync_btn_path)
	fullscreen_btn = get_node(fullscreen_btn_path)
	vsync_btn.pressed = OS.vsync_enabled
	fullscreen_btn.pressed = OS.window_fullscreen
