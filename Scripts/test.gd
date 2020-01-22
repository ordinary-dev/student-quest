extends VBoxContainer

func _on_Button_pressed():
	get_node("Label").text = get_node("LineEdit").text
	get_node("LineEdit").text = ""
	save_text()
	
func _on_Button2_pressed():
	get_tree().quit()
	
func get_text():
	var dict = {
		"text":get_node("Label").text
	}
	return dict

func save_text():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var node_data = get_text()
	save_game.store_line(to_json(node_data))
	save_game.close()
	
func _ready():
	var save_game = File.new()
	if save_game.file_exists("user://savegame.save"):
		save_game.open("user://savegame.save", File.READ)
		var current_line = parse_json(save_game.get_line())
		get_node("Label").text = current_line["text"]
		save_game.close()