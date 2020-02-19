extends Node2D


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_node("Position2D/Pause").switch()


func _ready():
	# UI parent obj
	var pos = Position2D.new()
	pos.name = "Position2D"
	add_child(pos)
	get_node("Body/Character/Camera2D/RemoteTransform2D").remote_path = "/root/Node2D/Position2D"
	
	get_node("/root/pause_init").init()
