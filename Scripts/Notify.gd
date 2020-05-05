extends Node

# Display a notification in top left corner

# Template
onready var scene : = preload("res://Scenes/global/Notification.tscn")
var id := 1


# Main function
func show(text : String) -> void:
	# Create new notification
	var temp = scene.instance()
	temp.name = str(id)
	temp.set_label(text)
	UI.get_node("Notifications").add_child(temp)
	var obj = UI.get_node("Notifications/" + str(id))
	obj.start_anim()
	id += 1
