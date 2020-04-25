extends Node

# Play sound when ready

export (String, FILE, "*.ogg") var file
export (float, 0.0, 5.0) var delay = 0.0

func _ready():
	yield(get_tree().create_timer(delay), "timeout")
	MUSIC.play_sound(file)
