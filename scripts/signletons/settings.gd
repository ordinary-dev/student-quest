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
	var fl := File.new()
	var state = fl.open(FILE_PATH, File.WRITE)
	assert(state == OK)
	# Save dictionary as JSON
	var dict = {
		"music": MUSIC.volume,
		"fx": FX.volume,
		"fullscreen": str(((get_window().mode == Window.MODE_EXCLUSIVE_FULLSCREEN) or (get_window().mode == Window.MODE_FULLSCREEN))),
		"vsync": str((DisplayServer.window_get_vsync_mode() != DisplayServer.VSYNC_DISABLED)),
		"lang": TranslationServer.get_locale(),
		"progress": progress,
	}
	fl.store_line(JSON.new().stringify(dict))
	fl.close()


func _ready() -> void:
	_read_settings()


func is_file_exist() -> bool:
	return File.new().file_exists(FILE_PATH)


# Try to read settings file
func _read_settings() -> void:
	var fl := File.new()
	if fl.file_exists(FILE_PATH):
		# Read data
		var state = fl.open(FILE_PATH, File.READ)
		assert(state == OK)
		var test_json_conv = JSON.new()
		test_json_conv.parse(fl.get_as_text())
		var json_result = test_json_conv.get_data()
		if json_result.error == OK:
			var content = json_result.result
			_restore(content)
		fl.close()
	else:
		_set_default()


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
