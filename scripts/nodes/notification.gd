extends Node
class_name Notification

# Simple script to show a
# notification when loading a scene

export (String) var text


func _ready() -> void:
	NOTIFY.show(text)
