# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Control

export (String, FILE, "*.tscn") var next_scene_path

export (String, FILE, "*.tscn") var phone_scene
export (String, FILE, "*.tscn") var commandant_scene

onready var buttons = $Buttons


func _ready() -> void:
	var sv_phone : String = TEMP.get("sv_phone")
	var sv_commandant : String = TEMP.get("sv_commandant")
	
	# Has the phone been checked?
	if sv_phone != "yes":
		buttons.add_option("CHECK_PHONE", phone_scene)
	
	# Did the player ask the commandant?
	if sv_commandant != "yes":
		buttons.add_option("ASK_COMMANDANT", commandant_scene)
	
	# Load next scene
	if sv_phone == "yes" and sv_commandant == "yes":
		yield(get_tree().create_timer(2), "timeout")
		SCENES.load_scene(next_scene_path)
	
