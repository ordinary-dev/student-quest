extends Node

var scene : = load("res://Scenes/global/Notification.tscn")

func show_notification(text : String) -> void:
	# Убрать предыдущее уведомление
	if has_node("/root/ui/notify"):
		get_node("/root/ui/notify").hide_self()
	# Создать новое
	var temp = scene.instance()
	temp.name = "notify"
	get_node("/root/ui").add_child(temp)
	get_node("/root/ui/notify").set_label(text)
	get_node("/root/ui/notify").start_anim()
