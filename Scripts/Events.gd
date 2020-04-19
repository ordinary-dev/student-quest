extends Node

# Game events handler


# Get event file contents
func get_event_info(event : String) -> Dictionary:
	var fp = File.new()
	var state = fp.open("res://Events/" + event + ".json", File.READ)
	assert(state == OK)
	var tmp = fp.get_as_text()
	var dict = parse_json(tmp)
	fp.close()
	return dict
