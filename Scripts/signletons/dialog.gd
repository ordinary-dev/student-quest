extends Node

# Dialog API
# It may be rewritten in the future
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

var is_shown := false
var _dialog_scene := load("res://Scenes/Templates/Dialog.tscn")
var _content: Array
var _index: int
# Call function after the dialog
var _call_fnc: bool
var _glob_obj: String
var _glob_fnc: String
var _glob_argv: String
# Remember whether the interface was hidden
# before the dialog was displayed
var _enable_pause_menu: bool
var _enable_joystick: bool


func show_dialog(path: String, obj := "", fnc := "", argv := "") -> void:
	is_shown = true
	# Try to open the file
	var fl := File.new()
	var state := fl.open(path, File.READ)
	if state != OK:
		NOTIFY.show("I can't load the dialog. Please report a bug.")
		return
	# Lock player movement
	if has_node(STORAGE.get("player_path")):
		get_node(STORAGE.get("player_path")).lock()
	# Disable the interface, if enabled, and remember this
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
	# Play sound
	FX.play_dialog_sound()
	# Save arguments
	if obj != "":
		_call_fnc = true
		_glob_obj = obj
		_glob_fnc = fnc
		_glob_argv = argv
	else:
		_call_fnc = false
	# Prepare interface
	var tmp = _dialog_scene.instance()
	tmp.name = "dialog"
	UI.add_child(tmp)
	# Read file
	var json_result = JSON.parse(fl.get_as_text())
	if json_result.error == OK:
			var content = json_result.result
			fl.close()
			# Save values
			_content = content
			_index = 0
			# Activate button processing
			set_process(true)
			# Show first phrase
			_show_next()
	else:
		NOTIFY.show("Can't process the dialog")
		fl.close()


func _hide_dialog():
	is_shown = false
	var dialog_obj = UI.get_node("dialog")
	dialog_obj.play_reverse()
	yield(get_tree().create_timer(dialog_obj.shape_time), "timeout")
	UI.remove_child(dialog_obj)
	set_process(false)
	# Unlock player movement
	if has_node(STORAGE.get("player_path")):
		get_node(STORAGE.get("player_path")).unlock()
	# Call a method if necessary
	if _call_fnc and has_node(_glob_obj):
		if _glob_argv == "":
			get_node(_glob_obj).call(_glob_fnc)
		else:
			get_node(_glob_obj).call(_glob_fnc, _glob_argv)
	_glob_obj = ""
	# Enable ui if necessary
	if _enable_pause_menu:
		UI.show_pause_menu = true
	if _enable_joystick:
		UI.show_joystick = true


func _process(_delta):
	if Input.is_action_just_pressed("dialog_next"):
		if _index != -1:
			_show_next()
		else:
			_hide_dialog()


func _show_next() -> void:
	# Show next phrase
	var dial = UI.get_node("dialog")
	dial.play_dialog(
		_content[_index]["name"],
		_content[_index]["text"]
	)
	# Connect signal and get id of the next phrase
	var btn = UI.get_node("dialog/" + dial.next_button)
	if _index < len(_content) - 1:
		btn.disconnect("pressed", self, "show_next")
		btn.connect("pressed", self, "show_next")
		_index += 1
	# If this is the last phrase
	else:
		if _index != 0:
			btn.disconnect("pressed", self, "show_next")
		_index = -1
		btn.connect("pressed", self, "hide_dialog")


func _ready():
	set_process(false)
