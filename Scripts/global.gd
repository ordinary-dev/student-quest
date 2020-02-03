extends Node

var health = 0
var type = 2
var potatos = 1
var file_name = "user://save_game.dat"

func gen_dict():
	var save_dict = {
		"health":health,
		"type":type,
		"potatos":potatos
	}
	return save_dict

func restore(content):
	health = content["health"]
	type = content["type"]
	potatos = content["potatos"]

func read_file(path=file_name):
	var fl = File.new()
	fl.open(path, File.READ)
	var content = parse_json(fl.get_line())
	fl.close()
	restore(content)
	
func write_file(path=file_name):
	var fl = File.new()
	fl.open(path, File.WRITE)
	var node = gen_dict()
	fl.store_line(to_json(node))
	fl.close()
	
	