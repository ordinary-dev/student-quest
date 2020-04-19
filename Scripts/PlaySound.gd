extends Node

# Play sound when ready

export (String, FILE, "*.ogg") var file

func _ready():
	FX.play_sound(load(file))
