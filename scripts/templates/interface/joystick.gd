extends Button

# Gonkee's joystick script for Godot 3
# https://youtu.be/uGyEP2LUFPg

var radius = Vector2(64, 64)
var boundary = 128
var ongoing_drag = -1
var return_accel = 20
var threshold = 10


func _process(delta) -> void:
	if ongoing_drag == -1:
		var pos_difference = (Vector2(0, 0) - radius) - rect_position
		rect_position += pos_difference * return_accel * delta


func get_button_pos() -> Vector2:
	return rect_position + radius


func _input(event) -> void:
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_centre = (event.position - get_parent().global_position).length()
		if event_dist_from_centre <= boundary * rect_scale.x or event.get_index() == ongoing_drag:
			set_global_position(event.position - radius * rect_scale)
			if get_button_pos().length() > boundary:
				set_position( get_button_pos().normalized() * boundary - radius)
			ongoing_drag = event.get_index()
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1


func get_value() -> Vector2:
	if get_button_pos().length() > threshold:
		return get_button_pos().normalized()
	return Vector2(0, 0)
