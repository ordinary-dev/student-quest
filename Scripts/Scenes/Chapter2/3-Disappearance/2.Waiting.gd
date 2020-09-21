extends Node2D

export (String, FILE, "*.tscn") var btn_scene_path


# Show 2 buttons
func load_scene(_val) -> void:
	var tmp = load(btn_scene_path).instance()
	add_child(tmp)
