extends Node

# Play random click sound
# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

onready var _audio_src = [
	$Click1,
	$Click2,
	$Click3
]


func play() -> void:
	var ind = randi() % _audio_src.size()
	_audio_src[ind].play()
