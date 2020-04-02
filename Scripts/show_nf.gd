extends Node

var scene : = load("res://Scenes/global/Notification.tscn")
var stack : Array


func display(text : String) -> void:
	# Создать новое
	var temp = scene.instance()
	temp.name = "notify"
	get_node("/root/ui/CanvasLayer").add_child(temp)
	get_node("/root/ui/CanvasLayer/notify").set_label(text)
	get_node("/root/ui/CanvasLayer/notify").start_anim()


func show_notification(text : String) -> void:
	# Поставить в очередь
	if has_node("/root/ui/CanvasLayer/notify"):
		stack.append(text)
	else:
		display(text)


func check_stack() -> void:
	yield(get_tree().create_timer(0.5), "timeout")
	if !has_node("/root/ui/CanvasLayer/notify"):
		if stack.size() != 0:
			display(stack[0])
			stack.pop_front()
