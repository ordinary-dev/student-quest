extends Node

@export var settings_panel: TabContainer


func _ready():
	settings_panel.visible = false


func _on_quit_btn_pressed():
	get_tree().quit()


func _on_settings_btn_pressed():
	settings_panel.visible = !settings_panel.visible
