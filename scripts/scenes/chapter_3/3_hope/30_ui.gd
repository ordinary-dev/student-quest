extends Sprite

# Animation of character movement on the screen
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

# Time between frame changes in seconds
const SEC := 1.0
# Elapsed time
var _time := 0.0


func _process(delta) -> void:
	_time += delta / SEC
	if _time > 1:
		_time = 0
		if frame == 0:
			frame = 3
		else:
			frame = 0
