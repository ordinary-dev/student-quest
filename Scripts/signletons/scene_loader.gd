extends Tween

# Custom scene loader
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

const START_COLOR := Color(0, 0, 0, 0)
const END_COLOR := Color(0, 0, 0, 1)
const TIME := 0.5
var last_scene_path: String


# Load scene by path
func load_scene(scene_name: String, anim_start := true, anim_end := true) -> void:
	# Check path
	var file_exists := File.new().file_exists(scene_name)
	if (!file_exists):
		NOTIFY.show("Can't find scene. Please report a bug.")
		return
	
	# Fade in
	if anim_start:
		_fade_in()
		yield(get_tree().create_timer(TIME), "timeout")
	
	# Save player position
	if has_node(STORAGE.get("player_path")):
		var pl = get_node(STORAGE.get("player_path"))
		if pl.restore_position:
			pl._save()
	
	# Load scene
	last_scene_path = scene_name
	var status = get_tree().change_scene(scene_name)
	if status != OK:
		NOTIFY.show("Can't change scene. Please report a bug.")
	
	# Fade out
	if anim_end:
		if !anim_start:
			_create_color_rect()
			UI.get_node("transition").color = END_COLOR
		_fade_out()
	elif anim_start:
		UI.get_node("transition").queue_free()


# Create transparent color rect
func _create_color_rect() -> void:
	var tmp := ColorRect.new()
	tmp.mouse_filter = Control.MOUSE_FILTER_IGNORE
	tmp.color = START_COLOR
	tmp.name = "transition"
	tmp.rect_min_size = Vector2(1920, 1080)
	UI.add_child(tmp)


func _fade_in() -> void:
	_create_color_rect()
	var color_rect = UI.get_node("transition")
	interpolate_property(
		color_rect, "color",
		START_COLOR, END_COLOR, TIME, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	start()


func _fade_out() -> void:
	var color_rect = UI.get_node("transition")
	interpolate_property(
		color_rect, "color",
		END_COLOR, START_COLOR, TIME, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	start()
	yield(get_tree().create_timer(TIME), "timeout")
	UI.remove_child(color_rect)
