extends Node


const SHOW_CONTROLS = false


func show_time(time) -> void:
	UI.get_node("Time").set_time(time)
	UI.get_node("Time").start()
	UI.get_node("Time").visible = true


func hide_time() -> void:
	UI.get_node("Time").stop()
	UI.get_node("Time").visible = false


func hide_joystick() -> void:
	UI.get_node("Joystick").visible = false


func show_joystick() -> void:
	UI.get_node("Joystick").visible = true


func enable_ui() -> void:
	if OS.get_name() == "Android" or SHOW_CONTROLS:
		UI.get_node("Joystick").visible = true
	UI.get_node("Pause").visible = true
	UI.get_node("Inventory").visible = true
	UI.get_node("Inventory").update_inv()


func disable_ui() -> void:
	UI.get_node("Joystick").visible = false
	UI.get_node("Pause").visible = false
	UI.get_node("Inventory").visible = false
