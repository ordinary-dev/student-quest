extends Node

# Display a notification in top left corner
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

var _id := 1
onready var _template := preload("res://scenes/templates/interface/notification.tscn")


func show(text: String) -> void:
	# Create new notification
	var tmp = _template.instance()
	tmp.name = str(_id)
	tmp.set_label(text)
	# Add object and start animation
	UI.get_node("Notifications").add_child(tmp)
	var obj = UI.get_node("Notifications/" + str(_id))
	obj.start_anim()
	# Increment id
	if _id < 1000:
		_id += 1
	else:
		_id = 0
