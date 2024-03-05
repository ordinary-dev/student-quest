extends AudioStreamPlayer

# Small API for music player
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const MAX_VOLUME := 5
const MIN_VOLUME := -35
var volume: float: get = _get_volume, set = _set_volume
@onready var _last_path := "no_song"


func play_sound(song_path: String) -> void:
	if (_last_path != song_path):
		_last_path = song_path
		stream = load(song_path)
	if (!playing):
		play()


func _set_volume(value: float) -> void:
	pass


func _get_volume() -> float:
	return volume
