extends Node

# Display a notification in top left corner
# Avaiable at /root/notify

# Template
onready var scene : = preload("res://Scenes/global/Notification.tscn")
var id := 1


# Main function
func show(text : String) -> void:
	# Create new notification
	var temp = scene.instance()
	temp.name = str(id)
	UI.get_node("Notifications").add_child(temp)
	var obj = UI.get_node("Notifications/" + str(id))
	obj.set_label(text)
	obj.start_anim()
	id += 1
