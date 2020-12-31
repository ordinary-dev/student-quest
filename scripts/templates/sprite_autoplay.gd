extends AnimatedSprite

# Autoplay animation.
# This allows you not to overwrite
# the frame number when saving a scene.
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License


func _ready() -> void:
	play()
