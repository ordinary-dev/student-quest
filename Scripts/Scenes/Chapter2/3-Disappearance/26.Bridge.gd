extends Node2D

export (String, FILE, "*.json") var dialog_path
export (String, FILE, "*.json") var dialog_path_2
onready var stranger = $Characters/Stranger
onready var teleport_trigger = $Teleports/TeleportTrigger
onready var teleport_trigger_2 = $Teleports/TeleportTrigger2
onready var teleport_trigger_3 = $Teleports/TeleportTrigger3
var used = false

export (String, FILE, "*.tscn") var scene_path


func teleport() -> void:
	stranger.set_process(false)
	get_node(GLOBAL.player_path).go_left()
	get_node(GLOBAL.player_path).position.x -= 800
	stranger.position.x -= 800
	yield(get_tree().create_timer(1), "timeout")
	DIALOG.show_dialog(dialog_path_2, get_path(), "move_2")


func teleport_2() -> void:
	get_node(GLOBAL.player_path).go_left()
	get_node(GLOBAL.player_path).position.x -= 800
	stranger.position.x -= 800
	teleport_trigger_3.enabled = true


func teleport_3() -> void:
	SCENES.load_scene(scene_path)


func move() -> void:
	stranger.set_process(true)
	teleport_trigger.enabled = true


func move_2() -> void:
	stranger.set_process(true)
	teleport_trigger_2.enabled = true


func show_dialog() -> void:
	if not used:
		DIALOG.show_dialog(dialog_path, get_path(), "move")
		used = true
