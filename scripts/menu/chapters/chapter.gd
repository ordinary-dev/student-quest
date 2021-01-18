extends ColorRect

# Script for hiding an unavailable Chapter
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const BG_COLOR_ENABLED := "#232323"
const BG_COLOR_DISABLED := "#303030"
const SECRET_TEXT := "../.."

export (StreamTexture) var texture
export (String) var chapter_name
export (String, FILE, "*.tscn") var path_to_scene

var enabled setget _set_state

onready var _label = $MarginContainer/Content/Label
onready var _image = $MarginContainer/Content/TextureRect
onready var _btn = $Button


# Assigned by load script
func _set_state(val: bool) -> void:
	enabled = val
	if enabled:
		_image.texture = texture
		_label.text = chapter_name
		_btn.disabled = false
		color = Color(BG_COLOR_ENABLED)
	else:
		_btn.disabled = true
		_label.text = SECRET_TEXT
		color = Color(BG_COLOR_DISABLED)


func _on_button_pressed() -> void:
	MUSIC.stop()
	get_tree().paused = false
	SCENES.load_scene(path_to_scene)
