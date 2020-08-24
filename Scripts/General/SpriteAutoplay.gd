# Autoplay animation

# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

extends AnimatedSprite


func _ready() -> void:
	# This allows you not to overwrite
	# the frame number when saving a scene
	play()
