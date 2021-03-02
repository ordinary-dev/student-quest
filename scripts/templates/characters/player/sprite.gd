extends Sprite


enum States {DOWN, UP, LEFT, RIGHT}

enum Frames {DOWN_1, UP_1, SIDE_1,
		DOWN_2, UP_2, SIDE_2,
		DOWN_STILL, UP_STILL, SIDE_STILL}

const MAIN_SPRITE := "res://sprites/characters/alex/alex.png"
const NEO_SPRITE := "res://sprites/characters/neo.png"


func load_neo_spirte():
	texture = load(NEO_SPRITE)


func load_main_spirte():
	texture = load(MAIN_SPRITE)


func _freeze_frame(state) -> void:
	match state:
		States.UP:
			frame = Frames.UP_STILL
		States.DOWN:
			frame = Frames.DOWN_STILL
		_:
			frame = Frames.SIDE_STILL
