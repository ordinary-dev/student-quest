extends Node

# Works with settings
# Tries to read them at start
# Also saves settings to file
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

# Path to config file
const FILE_PATH := "user://config.json"
# Variable for saving the number of open chapters
var progress := 1


# Write dictionary to file
func write_settings() -> void:
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	# Save dictionary as JSON
	var dict = {
		"music": MUSIC.volume,
		"fx": FX.volume,
		"fullscreen": str(((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))),
		"vsync": str((DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED)),
		"lang": TranslationServer.get_locale(),
		"progress": progress,
	}
	file.store_line(JSON.stringify(dict))


func _ready() -> void:
	_read_settings()


func is_file_exist() -> bool:
	return FileAccess.file_exists(FILE_PATH)


# Try to read settings file
func _read_settings() -> void:
	if not FileAccess.file_exists(FILE_PATH):
		_set_default()
	
	# Read data
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	var test_json_conv = JSON.new()
	if file == null:
		_set_default()
		return
	var err = test_json_conv.parse(file.get_as_text())
	if err != OK:
		_set_default()
		return
	
	var content = test_json_conv.get_data()
	_restore(content)


# Restore existing values from json file
func _restore(content: Dictionary) -> void:
	# Audio
	if content.has("music"):
		MUSIC.volume = content["music"]
	if content.has("fx"):
		FX.volume = content["fx"]
	
	# Graphics
	if content.has("fullscreen"):
		get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (_str_to_bool(content["fullscreen"])) else Window.MODE_WINDOWED
	if content.has("vsync"):
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if (_str_to_bool(content["vsync"])) else DisplayServer.VSYNC_DISABLED)
	
	# Language
	if content.has("lang"):
		TranslationServer.set_locale(content["lang"])
	
	# Save
	if content.has("progress"):
		progress = content["progress"]


func _str_to_bool(val: String) -> bool:
	return val == "True" or val == "true"


# Set default values
func _set_default() -> void:
	MUSIC.volume = 0
	FX.volume = 0
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED if (true) else DisplayServer.VSYNC_DISABLED)
	get_window().mode = Window.MODE_EXCLUSIVE_FULLSCREEN if (true) else Window.MODE_WINDOWED
	TranslationServer.set_locale("en")
