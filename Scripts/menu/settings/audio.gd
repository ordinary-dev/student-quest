extends Node

# Audio settings
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

onready var _music_label := $Container/Music/Volume
onready var _effects_label := $Container/Effects/EffectsVolume


func change_music_vol(delta: int) -> void:
	FX.play_btn_click()
	MUSIC.volume += delta
	_update_text(MUSIC.volume, _music_label)


func change_effect_vol(delta: int) -> void:
	FX.play_btn_click()
	FX.volume += delta
	_update_text(FX.volume, _effects_label)


func reset_music_volume() -> void:
	FX.play_btn_click()
	MUSIC.volume = 0
	_update_text(0, _music_label)


func reset_effect_volume() -> void:
	FX.play_btn_click()
	FX.volume = 0
	_update_text(0, _effects_label)


func _ready() -> void:
	_update_text(FX.volume, _effects_label)
	_update_text(MUSIC.volume, _music_label)


# Converts the volume to a percentage
# and changes the text
func _update_text(val: float, obj: Label) -> void:
	obj.text = str(round((val+35)/35*100)) + "%"
