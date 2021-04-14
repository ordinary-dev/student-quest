extends Node

# Dialog API
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const DIALOG_SCENE := preload("res://scenes/templates/interface/dialog.tscn")
var is_shown := false
# Call function after the dialog
var _call_fnc: bool
var _obj: String
var _method: String
var _argv: String
# Remember whether the interface was hidden
# before the dialog was displayed
var _enable_pause_menu: bool
var _enable_joystick: bool
var _index: int
var _content


func show_dialog(file_path: String, obj := "", method := "", argv := "") -> void:
	# Try to read the json file
	if _read_file(file_path) == false:
		return
	# Lock player movement
	var player_path = STORAGE.get("player_path")
	if has_node(player_path):
		get_node(player_path).lock()
	# Save arguments
	if obj != "" and method != "":
		_call_fnc = true
		_obj = obj
		_method = method
		_argv = argv
	else:
		_call_fnc = false
	# Play sound
	FX.play_dialog_sound()
	# Disable the interface, if enabled, and remember this
	_hide_interface()
	_create_dialog_obj()
	# Activate button processing
	set_process(true)
	# Show first phrase
	is_shown = true
	_index = 0
	show_next()


func show_next() -> void:
	# Show next phrase
	var dialog = UI.get_node("dialog")
	dialog.play_dialog(
		_content[_index]["name"],
		_content[_index]["text"]
	)
	_index += 1
	# Next phrase is last
	if _index == len(_content):
		var btn = dialog.next_button
		btn.disconnect("pressed", self, "show_next")
		btn.connect("pressed", self, "hide_dialog")


func hide_dialog():
	is_shown = false
	var dialog = UI.get_node("dialog")
	dialog.hide()
	set_process(false)
	# Unlock player movement
	var player_path = STORAGE.get("player_path")
	if has_node(player_path):
		get_node(player_path).unlock()
	# Call a method if necessary
	if _call_fnc:
		if has_node(_obj):
			if _argv == "":
				get_node(_obj).call(_method)
			else:
				get_node(_obj).call(_method, _argv)
	# Enable ui if necessary
	if _enable_pause_menu:
		UI.show_pause_menu = true
	if _enable_joystick:
		UI.show_joystick = true


# Try to read the file
# Returns true if there were no errors
func _read_file(file_path: String) -> bool:
	var fl := File.new()
	var state := fl.open(file_path, File.READ)
	if state != OK:
		NOTIFY.show("I can't load the dialog. Please report a bug.")
		return false
	# Try to read the file
	var json_result = JSON.parse(fl.get_as_text())
	fl.close()
	if json_result.error != OK:
		NOTIFY.show("Can't parse the file. Please report a bug.")
		return false
	_content = json_result.result
	return true


func _hide_interface() -> void:
	if UI.show_joystick:
		UI.show_joystick = false
		_enable_joystick = true
	else:
		_enable_joystick = false
	if UI.show_pause_menu:
		UI.show_pause_menu = false
		_enable_pause_menu = true
	else:
		_enable_pause_menu = false


func _create_dialog_obj() -> void:
	var tmp = DIALOG_SCENE.instance()
	tmp.name = "dialog"
	UI.add_child(tmp)
	UI.get_node("dialog").next_button.connect("pressed", self, "show_next")


func _process(_delta) -> void:
	if Input.is_action_just_pressed("dialog_next"):
		if _index != len(_content):
			show_next()
		else:
			hide_dialog()


func _ready() -> void:
	set_process(false)
