# Play random click sound

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends Node

onready var audio_src = [
	$Click1,
	$Click2,
	$Click3
]

func play():
	var ind : int = randi() % 3
	audio_src[ind].play()
