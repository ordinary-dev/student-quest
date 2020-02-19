extends Node

export var scene = "res://Scenes/pause.tscn"

func init():
	var sc = load(scene).instance()
	sc.name = "Pause"
	get_node("/root/Node2D/Position2D").add_child(sc)
