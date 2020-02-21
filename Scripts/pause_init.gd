extends Node

export (String, FILE, "*.tscn") var pause_scene = "res://Scenes/pause.tscn"
export (String, FILE, "*.tscn") var contr_scene = "res://Scenes/Controls.tscn"
var SHOW_CONTROLS = false

func init():
	var sc = load(pause_scene).instance()
	sc.name = "Pause"
	get_node("/root/Node2D/Position2D").add_child(sc)
	if OS.get_name() == "Android" || SHOW_CONTROLS:
		sc = load(contr_scene).instance()
		sc.name = "Controls"
		get_node("/root/Node2D/Position2D").add_child(sc)
