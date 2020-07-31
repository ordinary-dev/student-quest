# Autoplay animation

# Copyright (c) 2020 PixelTrain
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

extends AnimatedSprite


func _ready() -> void:
	# This allows you not to overwrite
	# the frame number when saving a scene
	play()
