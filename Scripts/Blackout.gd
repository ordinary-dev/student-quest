extends Node2D

# Turn off the lights

export (String, FILE, "*.tscn") var next_scene
export (String, FILE, "*.tscn") var hidden_room 

export (String, FILE, "*.json") var dialog_1
export (String, FILE, "*.json") var dialog_2
export (String, FILE, "*.json") var dialog_3
var ind = 1

onready var trigger_1 = $"GuardDialog-Trigger_Area2D_0"
onready var trigger_2 = $"Stairs-DialogTrigger-Trigger_Area2D_0"

onready var color_rect = $CanvasLayer/Blackout_ColorRect
onready var tween = $Tween
onready var map = $"Math-map-Template"

const c1 := Color("#00080808")
const c2 := Color("#ee080808")


func dialog() -> void:
	if ind == 1:
		DIALOG.show_dialog(dialog_1)
		ind = 2
	elif ind == 2:
		DIALOG.show_dialog(dialog_2)
		ind = 3
	else:
		DIALOG.show_dialog(dialog_3)


func turn_lights_off():
	yield(get_tree().create_timer(2), "timeout")
	tween.interpolate_property(
		color_rect, "color",
		c1, c2, 1,
		Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.start()


func turn_lights_on():
	#tween.interpolate_property(
	#	color_rect, "color",
	#	c2, c1, 1,
	#	Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	#tween.start()
	#map.block_turnstile = false
	#remove_child(trigger_1)
	#remove_child(trigger_2)
	SCENES.load_scene(next_scene)

func _ready():
	turn_lights_off()
