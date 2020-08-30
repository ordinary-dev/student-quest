extends Tween

var last_scene_path : String
const time := 0.5
const start := Color(0, 0, 0, 0)
const end := Color(0, 0, 0, 1)


func create_color_rect() -> void:
	var tmp := ColorRect.new()
	tmp.mouse_filter = Control.MOUSE_FILTER_IGNORE
	tmp.color = start
	tmp.name = "transition"
	tmp.rect_min_size = Vector2(1920, 1080)
	UI.add_child(tmp)


func fade_in() -> void:
	create_color_rect()
	var color_rect = UI.get_node("transition")
	interpolate_property(
		color_rect, "color",
		start, end, time, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	start()


func fade_out() -> void:
	var color_rect = UI.get_node("transition")
	interpolate_property(
		color_rect, "color",
		end, start, time, 
		Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	start()
	yield(get_tree().create_timer(time), "timeout")
	UI.remove_child(color_rect)


# Load any scene by path
func load_scene(scene_name : String, anim_start : bool = true, anim_end : bool = true) -> void:
	# Check
	var file_exists := Directory.new().file_exists(scene_name)
	if (!file_exists):
		NOTIFY.show("Can't find scene")
		return
	
	# Fade in
	if anim_start:
		fade_in()
		yield(get_tree().create_timer(time), "timeout")
	
	# Save position
	if has_node(GLOBAL.player_path):
		var pl = get_node(GLOBAL.player_path)
		if pl.restore_position:
			pl._save()
	# Load scene
	last_scene_path = scene_name
	assert(get_tree().change_scene(scene_name) == OK)
	
	# Fade out
	if anim_end:
		if !anim_start:
			create_color_rect()
			UI.get_node("transition").color = end
		fade_out()
	elif anim_start:
		UI.get_node("transition").queue_free()
