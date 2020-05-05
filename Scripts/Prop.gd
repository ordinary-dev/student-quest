extends Node

# Able to load and save game data
# user://game_id/param


# Get game parameter
# Returns -1 on error
func get(param : String, game_id : String = "null") -> String:
	# Open file
	var fp : = File.new()
	if game_id == "null":
		game_id = GLOBAL.loaded
	if game_id == "-1":
		NOTIFY.show("NOTLOADED")
		return "-1"
	else:
		var path : = "user://" + game_id + "/" + param
		var state : = fp.open(path, File.READ)
		if state != OK:
			return "-1"
		# Read it
		var val : = fp.get_line()
		fp.close()
		return val


# Save Game Parameter
func save(param : String, value) -> void:
	var game_id := GLOBAL.loaded
	if game_id == "-1":
		NOTIFY.show("NOTLOADED")
		NOTIFY.show("NOTSAVED")
		return
	
	var dir : = Directory.new()
	var dir_path : = "user://" + game_id
	
	# Create folder if not present
	if not dir.dir_exists(dir_path):
		var state : = dir.make_dir(dir_path)
		assert(state == OK)
	
	# Write value to file
	var fp : = File.new()
	var state : = fp.open(dir_path + "/" + param, File.WRITE)
	assert(state == OK)
	fp.store_line(str(value))
	fp.close()


func has(param : String) -> bool:
	var game_id := GLOBAL.loaded
	var path : = "user://" + game_id + "/" + param
	var fp : = File.new()
	var state : = fp.open(path, File.READ)
	return state == OK
