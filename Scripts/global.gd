extends Node

# Volume of audio players
onready var ost = get_node("/root/ost")
onready var fx = get_node("/root/fx")

# File to read and write data
var file_name = "user://save_game.dat"

# For easier changes in future
var ost_field = "ost_vol"
var fx_field = "fx_vol"

func gen_dict():
	var save_dict = {
		ost_field:ost.volume_db,
		fx_field:fx.volume_db
	}
	return save_dict

func restore(content):
	if content.has(ost_field):
		ost.volume_db = content[ost_field]
	if content.has(fx_field):
		fx.volume_db = content[fx_field]

func read_file(path=file_name):
	var fl = File.new()
	if fl.file_exists(path):
		# Restore saved data
		fl.open(path, File.READ)
		var content = parse_json(fl.get_line())
		fl.close()
		restore(content)
	else:
		# Default values
		ost.volume_db = 0
		fx.volume_db = 0
	
func write_file(path=file_name):
	var fl = File.new()
	fl.open(path, File.WRITE)
	fl.store_line(to_json(gen_dict()))
	fl.close()
	
