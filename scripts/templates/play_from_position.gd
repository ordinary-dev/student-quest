extends AudioStreamPlayer

# Copyright (c) 2020-2021 PixelTrain
# Licensed under the GPL-3 License

@export var position: float = 0.0


func _ready() -> void:
	play(position)
