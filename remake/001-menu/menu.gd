extends Node

const FILE_PATH = "user://settings.json"
const KEYS = {
	MUSIC_VOLUME = "music_volume",
	SOUND_VOLUME = "sound_volume",
	FULLSCREEN = "fullscreen",
	VSYNC = "vsync",
}

@export var settings_panel: TabContainer
@export var fullscreen_checkbox: CheckButton
@export var vsync_checkbox: CheckButton

@export var music_vol_slider: HSlider
@export var sound_vol_slider: HSlider


func load_settings():
	if not FileAccess.file_exists(FILE_PATH):
		print_debug("settings file does not exist")
		return
	
	var settings_file = FileAccess.open(FILE_PATH, FileAccess.READ)
	if settings_file == null:
		printerr("unexpected error when openning a settings file")
		return
	
	var json_parser = JSON.new()
	var err = json_parser.parse(settings_file.get_as_text())
	if err != OK:
		printerr("json parsing error: %s" % err)
		return
	
	var settings = json_parser.data
	
	# Fullscreen
	if settings.has(KEYS.FULLSCREEN) and settings[KEYS.FULLSCREEN]:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen_checkbox.button_pressed = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen_checkbox.button_pressed = false
		
	# Vsync
	if settings.has(KEYS.VSYNC) and settings[KEYS.VSYNC]:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		vsync_checkbox.button_pressed = true
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		vsync_checkbox.button_pressed = false
	
	if settings.has(KEYS.MUSIC_VOLUME):
		var vol = settings[KEYS.MUSIC_VOLUME]
		AudioServer.set_bus_volume_db(1, vol)
		AudioServer.set_bus_mute(1, vol < -29)
		music_vol_slider.value = vol
	if settings.has(KEYS.SOUND_VOLUME):
		var vol = settings[KEYS.SOUND_VOLUME]
		AudioServer.set_bus_volume_db(2, vol)
		AudioServer.set_bus_mute(2, vol < -29)
		sound_vol_slider.value = vol


func save_settings():
	var settings = {
		KEYS.FULLSCREEN: fullscreen_checkbox.button_pressed,
		KEYS.VSYNC: vsync_checkbox.button_pressed,
		KEYS.MUSIC_VOLUME: music_vol_slider.value,
		KEYS.SOUND_VOLUME: sound_vol_slider.value,
	}
	
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	if file == null:
		printerr("unexpected error when opening settings file")
		return
	
	file.store_string(JSON.stringify(settings))
	file.close()


func _ready():
	load_settings()
	settings_panel.visible = false


func _on_quit_btn_pressed():
	save_settings()
	get_tree().quit()


func _on_settings_btn_pressed():
	settings_panel.visible = !settings_panel.visible


func _on_fullscreen_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_vsync_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _on_sound_vol_slider_value_changed(value):
	AudioServer.set_bus_mute(2, value <= -29)
	AudioServer.set_bus_volume_db(2, value)


func _on_music_vol_slider_value_changed(value):
	AudioServer.set_bus_mute(1, value <= -29)
	AudioServer.set_bus_volume_db(1, value)
