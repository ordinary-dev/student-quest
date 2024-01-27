extends Node
class_name Notification

# Simple script to show a
# notification when loading a scene

@export var text: String


func _ready() -> void:
	NOTIFY.show(text)
