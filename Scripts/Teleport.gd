extends Node2D

# Teleport
export (NodePath) var p1
export (NodePath) var p2
export (NodePath) var p3
export (String, FILE, "*.tscn") var street_path


func teleport(node : String) -> void:
	SCENES.fade_in()
	yield(get_tree().create_timer(SCENES.time), "timeout")
	get_node("/root/Node2D/Body").position = get_node(node).position
	SCENES.fade_out()


func floor_1():
	teleport(p1)


func floor_2():
	teleport(p2)


func floor_3():
	teleport(p3)


func street():
	SCENES.load_scene(street_path)
