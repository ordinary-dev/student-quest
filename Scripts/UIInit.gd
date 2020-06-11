extends Node


const SHOW_CONTROLS = false


func show_time(time) -> void:
	UI.get_node("Time-UI_Control").set_time(time)
	UI.get_node("Time-UI_Control").start()
	UI.get_node("Time-UI_Control").visible = true


func hide_time() -> void:
	UI.get_node("Time-UI_Control").stop()
	UI.get_node("Time-UI_Control").visible = false


func hide_joystick() -> void:
	UI.get_node("Joystick-UI_Sprite").visible = false


func show_joystick() -> void:
	UI.get_node("Joystick-UI_Sprite").visible = true


func enable_ui(joystick := false) -> void:
	if joystick and (OS.get_name() == "Android" or SHOW_CONTROLS):
		UI.get_node("Joystick-UI_Sprite").visible = true
	UI.get_node("PauseMenu-UI_Control").visible = true
	UI.get_node("PauseMenu-UI_Control").set_process(true)


func disable_ui() -> void:
	UI.get_node("Joystick-UI_Sprite").visible = false
	UI.get_node("PauseMenu-UI_Control").visible = false
	UI.get_node("PauseMenu-UI_Control").set_process(false)
