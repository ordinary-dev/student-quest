extends Node2D

onready var nav_2d : Navigation2D = $Navigation2D
onready var character : Sprite = $Character
export var song : = "res://Audio/music/SummerNight.ogg"

func _ready():
	get_node("/root/ost").play_sound(load(song))

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			var new_path : = nav_2d.get_simple_path(character.position, event.position)
			character.path = new_path
