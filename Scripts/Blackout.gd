extends Node2D

# Turn off the lights

export (String, FILE, "*.tscn") var hidden_room 

onready var color_rect = $CanvasLayer/ColorRect
onready var tween = $Tween
onready var collision = $Pass/CollisionShape2D
onready var guard = $Guard

const c1 := Color("#00080808")
const c2 := Color("#ee080808")


func adventure_begins():
	SCENES.load_scene(hidden_room)


func next_facility():
	NOTIFY.show("У вас нет доступа")


func turn_lights_off():
	yield(get_tree().create_timer(2), "timeout")
	TEMP.save("LIGHTS_OFF", true)
	tween.interpolate_property(
		color_rect, "color",
		c1, c2, 1,
		Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.start()


func turn_lights_off_now():
	color_rect.color = c2


func turn_lights_on():
	TEMP.remove_key("LIGHTS_OFF")
	tween.interpolate_property(
		color_rect, "color",
		c2, c1, 1,
		Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.start()
	collision.disabled = true
	guard.used = true


func _ready():
	if TEMP.is_saved("LIGHTS_OFF"):
		turn_lights_off_now()
	else:
		turn_lights_off()
