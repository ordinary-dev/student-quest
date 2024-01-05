extends Button

# I don't remember why such code
# is needed, but it seems to work


func _emit_once(name: String) -> void:
	var ev := InputEventAction.new()
	ev.action = name
	ev.button_pressed = true
	Input.parse_input_event(ev)
	ev.button_pressed = false
	await get_tree().create_timer(0.3).timeout
	Input.parse_input_event(ev)


func _on_Accept_pressed() -> void:
	_emit_once("dialog_start")
