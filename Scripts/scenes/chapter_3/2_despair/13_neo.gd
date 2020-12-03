extends Sprite

# Approaches the player,
# starts a dialog,
# and passes control to the singer

const MAX_X_POS := 800
const SPEED := 250
const DELAY := 30
export (String, FILE, "*.json") var dialog_path
var _current_frame := 0
onready var _blood := $AnimatedSprite
onready var _singer := $"../Singer"


func enable_ai() -> void:
	set_process(true)
	visible = true


func _ready() -> void:
	set_process(false)


func _process(delta) -> void:
	if position.x < MAX_X_POS:
		position.x += delta * SPEED
		if _current_frame < DELAY:
			_current_frame += 1
		else:
			_current_frame = 0
			if frame == 2:
				frame = 5
			else:
				frame = 2
	else:
		frame = 8
		set_process(false)
		DIALOG.show_dialog(dialog_path, get_path(), "show_singer")


func show_singer() -> void:
	_singer.enable_ai()


func blood() -> void:
	position.x += 10
	_blood.visible = true
	_blood.play()
