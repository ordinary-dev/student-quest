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
	TranslationServer.set_locale("en")
