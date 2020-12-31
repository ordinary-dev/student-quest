extends AudioStreamPlayer

# Small API for music player
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

const MAX_VOLUME := 5
const MIN_VOLUME := -35
var volume: float setget _set_volume, _get_volume
onready var _last_path := "no_song"


func play_sound(song_path: String) -> void:
	if (_last_path != song_path):
		_last_path = song_path
		stream = load(song_path)
	if (!playing):
		play()


func _set_volume(value: float) -> void:
	if value > MAX_VOLUME:
		value = MAX_VOLUME
	elif value < MIN_VOLUME:
		value = MIN_VOLUME
	volume = value
	AudioServer.set_bus_volume_db(1, volume)
	# Mute
	if volume == MIN_VOLUME:
		AudioServer.set_bus_mute(1, true)
	elif AudioServer.is_bus_mute(1):
		AudioServer.set_bus_mute(1, false)


func _get_volume() -> float:
	return volume
