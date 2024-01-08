extends AudioStreamPlayer

# Audio player for effects
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

const MAX_VOLUME := 5
const MIN_VOLUME := -35
@export var btn_click_sound: AudioStream
@export var dialog_sound: AudioStream
var volume: float: get = _get_volume, set = _set_volume
var _num := 0


func play_sound(obj: AudioStream) -> void:
	# Is this player free?
	if (!playing):
		stream = obj
		play()
	# This music player isn't free
	else:
		# Create new player
		var player : = AudioStreamPlayer.new()
		player.name = str(_num)
		player.stream = obj
		player.bus = "FX"
		# Destroy the new audio player at the end
		var state = player.connect("finished", Callable(self, "_destroy").bind(_num))
		assert(state == OK)
		# Play audio
		add_child(player)
		get_node(str(_num)).play()
		# Increment num
		if _num < 1000:
			_num += 1
		else:
			_num = 0


func play_btn_click() -> void:
	play_sound(btn_click_sound)


func play_dialog_sound() -> void:
	play_sound(dialog_sound)


func _set_volume(value: float) -> void:
	if value > MAX_VOLUME:
		value = MAX_VOLUME
	elif value < MIN_VOLUME:
		value = MIN_VOLUME
	volume = value
	AudioServer.set_bus_volume_db(2, volume)
	# Mute
	if volume == MIN_VOLUME:
		AudioServer.set_bus_mute(2, true)
	elif AudioServer.is_bus_mute(2):
		AudioServer.set_bus_mute(2, false)


func _get_volume() -> float:
	return volume


func _destroy(idx: int) -> void:
	var player = get_node(str(idx))
	remove_child(player)
