extends Control

# The script responsible for the
# operation of the pause menu
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

export (String, FILE, "*.tscn") var menu_scene
export (String, FILE, "*.tscn") var quit_scene
export (NodePath) var return_btn

var enabled := false
var show_joystick := false

onready var main_container := $MainContainer
onready var background := $Background
onready var pause_btn = $PauseButton
onready var settings := $MainContainer/HBoxContainer/SubMenues/Settings
onready var load_menu := $MainContainer/HBoxContainer/SubMenues/LoadMenu


func switch():
	if enabled:
		_return_to_game()
	elif UI.show_pause_menu:
		_on_Pause_pressed()


func _ready() -> void:
	assert(File.new().file_exists(menu_scene))
	assert(File.new().file_exists(quit_scene))
	assert(has_node(return_btn))
	main_container.visible = false
	background.visible = false


func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		switch()


func _on_Pause_pressed() -> void:
	enabled = true
	FX.play_btn_click()
	
	# Show pause menu
	main_container.visible = true
	background.visible = true
	pause_btn.visible = false
	
	# Hide joystick
	if UI.show_joystick:
		UI.show_joystick = false
		show_joystick = true
	
	# Stop the game
	get_tree().paused = true
	
	# Focus
	get_node(return_btn).grab_focus()


func _return_to_game(play_sound := true) -> void:
	enabled = false
	if play_sound:
		FX.play_btn_click()
	
	# Hide pause menu
	main_container.visible = false
	background.visible = false
	pause_btn.visible = true
	
	# Hide submenues
	settings.visible = false
	load_menu.visible = false
	
	# Continue the game
	get_tree().paused = false
	
	# Enable joystick again if it was hidden
	if show_joystick:
		UI.show_joystick = true
	show_joystick = false


func _to_menu() -> void:
	FX.play_btn_click()
	MUSIC.stop()
	SCENES.load_scene(menu_scene)
	yield(get_tree().create_timer(SCENES.time), "timeout")
	# Hide this scene
	_return_to_game(false)


# Quit game
func _quit_game() -> void:
	SCENES.load_scene(quit_scene)


# Show or hide settings
func _settings() -> void:
	FX.play_btn_click()
	settings.visible = !settings.visible
	load_menu.visible = false


# Load
func _load() -> void:
	FX.play_btn_click()
	settings.visible = false
	if load_menu.visible:
		load_menu.visible = false
	else:
		load_menu.refresh()
		load_menu.visible = true
