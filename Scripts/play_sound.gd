extends Node

export (String, FILE, "*.ogg") var file

func _ready():
	get_node("/root/fx").play_sound(load(file))
