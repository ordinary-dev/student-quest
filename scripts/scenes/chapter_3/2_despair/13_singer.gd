extends Sprite

# Approaches other characters and kills them

const DELAY := 30
const SPEED := 250
const MAX_X_POS := 600
export (String, FILE, "*.json") var dialog_path
export (String, FILE, "*.tscn") var scene_path
var _current_frame := 0
onready var _neo = $"../Neo"


func _ready() -> void:
	set_process(false)


func enable_ai() -> void:
	set_process(true)
	visible = true


func _process(delta):
	if position.x < MAX_X_POS:
		position.x += delta * SPEED
		if _current_frame < DELAY:
			_current_frame += 1
		else:
			_current_frame = 0
			if frame == 0:
				frame = 1
			else:
				frame = 0
	else:
		frame = 8
		set_process(false)
		_neo.flip_h = true
		DIALOG.show_dialog(dialog_path, get_path(), "shot")


func shot() -> void:
	yield(get_tree().create_timer(2), "timeout")
	frame = 2
	yield(get_tree().create_timer(1), "timeout")
	_neo.blood()
	yield(get_tree().create_timer(1.3), "timeout")
	SCENES.load_scene(scene_path, false, false)
