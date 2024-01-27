extends Node
class_name StageUnlocker

# Stage unlocker
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export var subchapter_id: int = 1


func _ready() -> void:
	if SETTINGS.progress < subchapter_id:
		SETTINGS.progress = subchapter_id
		SETTINGS.write_settings()
		NOTIFY.show("NEW_CHAPTER_UNLOCKED")
