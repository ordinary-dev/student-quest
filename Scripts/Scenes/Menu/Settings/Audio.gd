# Audio settings

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node

# Labels
export (NodePath) var music_text_path
export (NodePath) var effects_text_path

var music_text : Label
var effects_text : Label


func _ready() -> void:
	music_text = get_node(music_text_path)
	effects_text = get_node(effects_text_path)
	update_text(FX.volume, effects_text)
	update_text(MUSIC.volume, music_text)


# Update labels
func update_text(val : float, obj : Label) -> void:
	obj.text = str(round((val+35)/35*100)) + "%"


func change_music_vol(delta : int) -> void:
	FX.btn_click()
	MUSIC.volume += delta
	update_text(MUSIC.volume, music_text)


func change_effect_vol(delta : int) -> void:
	FX.btn_click()
	FX.volume += delta
	update_text(FX.volume, effects_text)


func reset_music_volume() -> void:
	FX.btn_click()
	MUSIC.volume = 0
	update_text(0, music_text)


func reset_effect_volume() -> void:
	FX.btn_click()
	FX.volume = 0
	update_text(0, effects_text)
