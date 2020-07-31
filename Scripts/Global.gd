extends Node

# Works with settings
# Tries to read them at start
# Also saves settings to file

# Path to config file
const file_path : = "user://config.json"

# Id of currently loaded game
var loaded : String = "-1"
var maxId := 0
var screenshot
var player_path : String

var first_run = false

# Create a dictionary to save
func gen_dict() -> Dictionary:
	var dict = {
		"music" : MUSIC.volume,
		"fx" : FX.volume,
		"fullscreen" : str(OS.window_fullscreen),
		"vsync" : str(OS.vsync_enabled),
		"lang" : TranslationServer.get_locale(),
		"maxId" : maxId
	}
	return dict


# Write dictionary to file
func write_settings() -> void:
	var fl = File.new()
	var state = fl.open(file_path, File.WRITE)
	assert(state == OK)
	# Save dictionary as JSON
	fl.store_line(to_json(gen_dict()))
	fl.close()


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
	if content.has("maxId"):
		maxId = content["maxId"]


# Read settings file
func read_settings() -> void:
	var fl = File.new()
	if fl.file_exists(file_path):
		# Read data
		var state = fl.open(file_path, File.READ)
		assert(state == OK)
		var content = parse_json(fl.get_line())
		fl.close()
		# Restore settings
		restore(content)
	else:
		# Default values
		first_run = true
		MUSIC.volume = 0
		FX.volume = 0
		OS.vsync_enabled = true
		OS.window_fullscreen = true
		TranslationServer.set_locale("ru")


func str_to_bool(val : String) -> bool:
	return val == "True" or val == "true"


func _ready() -> void:
	read_settings()

