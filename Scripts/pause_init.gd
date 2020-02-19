extends Node

export var scene = "res://Scenes/pause.tscn"
export var contr = "res://Scenes/Controls.tscn"
var SHOW_CONTROLS = false

func init():
	var sc = load(scene).instance()
	sc.name = "Pause"
	get_node("/root/Node2D/Position2D").add_child(sc)
	if OS.get_name() == "Android" || SHOW_CONTROLS:
		sc = load(contr).instance()
		sc.name = "Controls"
		get_node("/root/Node2D/Position2D").add_child(sc)
