extends Node

export (String, FILE, "*.tscn") var pause_scene = "res://Scenes/templates/pause.tscn"
export (String, FILE, "*.tscn") var contr_scene = "res://Scenes/templates/Controls.tscn"
var SHOW_CONTROLS = false

func init():
	var sc = load(pause_scene).instance()
	sc.name = "Pause"
	get_node("/root/ui").add_child(sc)
	if OS.get_name() == "Android" || SHOW_CONTROLS:
		sc = load(contr_scene).instance()
		sc.name = "Controls"
		get_node("/root/ui").add_child(sc)

func disable():
	if has_node("/root/ui/Pause"):
		get_node("/root/ui").remove_child(get_node("/root/ui/Pause"))
	if has_node("/root/ui/Controls"):
		get_node("/root/ui").remove_child(get_node("/root/ui/Controls"))
