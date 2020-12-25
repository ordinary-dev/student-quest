extends Node

# Works with settings
# Tries to read them at start
# Also saves settings to file
# Copyright (c) 2020 PixelTrain
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
		"fullscreen": str(OS.window_fullscreen),
		"vsync": str(OS.vsync_enabled),
		"lang": TranslationServer.get_locale(),
		"progress": progress,
	}
	fl.store_line(to_json(dict))
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
		var json_result = JSON.parse(fl.get_as_text())
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
		OS.window_fullscreen = _str_to_bool(content["fullscreen"])
	if content.has("vsync"):
		OS.vsync_enabled = _str_to_bool(content["vsync"])
	
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
	OS.vsync_enabled = true
	OS.window_fullscreen = true
	TranslationServer.set_locale("en")
