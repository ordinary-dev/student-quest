# Works with settings
# Tries to read them at start
# Also saves settings to file

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node

# Path to config file
const file_path : = "user://config.json"

# Id of currently loaded game
var loaded : String = "-1"

var player_path : String
var first_run := true
var progress := 1


# Write dictionary to file
func write_settings() -> void:
	var fl = File.new()
	var state = fl.open(file_path, File.WRITE)
	assert(state == OK)
	# Save dictionary as JSON
	fl.store_line(to_json(gen_dict()))
	fl.close()


# Create a dictionary to save
func gen_dict() -> Dictionary:
	var dict = {
		"music" : MUSIC.volume,
		"fx" : FX.volume,
		"fullscreen" : str(OS.window_fullscreen),
		"vsync" : str(OS.vsync_enabled),
		"lang" : TranslationServer.get_locale(),
		"progress" : progress
	}
	return dict


func _ready() -> void:
	read_settings()


# Read settings file
func read_settings() -> void:
	var fl = File.new()
	if fl.file_exists(file_path):
		# Read data
		var state = fl.open(file_path, File.READ)
		assert(state == OK)
		var json_result = JSON.parse(fl.get_as_text())
		if json_result.error == OK:
			var content = json_result.result
			first_run = false
			restore(content)
		fl.close()
	else:
		default()


func default() -> void:
	# Default values
	MUSIC.volume = 0
	FX.volume = 0
	OS.vsync_enabled = true
	OS.window_fullscreen = true
	TranslationServer.set_locale("en")


# Restore existing values
func restore(content : Dictionary) -> void:
	# Audio
	if content.has("music"):
		MUSIC.volume = content["music"]
	if content.has("fx"):
		FX.volume = content["fx"]
	
	# Graphics
	if content.has("fullscreen"):
		OS.window_fullscreen = str_to_bool(content["fullscreen"])
	if content.has("vsync"):
		OS.vsync_enabled = str_to_bool(content["vsync"])
	
	# Language
	if content.has("lang"):
		TranslationServer.set_locale(content["lang"])
	
	# Save
	if content.has("progress"):
		progress = content["progress"]


func str_to_bool(val : String) -> bool:
	return val == "True" or val == "true"

