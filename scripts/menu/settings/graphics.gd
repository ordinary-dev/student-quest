extends MarginContainer

# Graphics settings
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@onready var vsync_btn := $Buttons/VSync
@onready var fullscreen_btn := $Buttons/Fullscreen


func toggle_fullscreen_mode(state: bool) -> void:
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (state) else Window.MODE_WINDOWED


func toggle_vsync_mode(state: bool) -> void:
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if (state) else DisplayServer.VSYNC_DISABLED)


# Update interface
func _ready() -> void:
	vsync_btn.button_pressed = (DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED)
	fullscreen_btn.button_pressed = ((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))
