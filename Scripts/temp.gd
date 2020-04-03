extends Node


var dict : Dictionary

func is_saved(key:String) -> bool:
	return dict.has(key)

func save(key:String, data) -> void:
	dict[key] = data
	
func get(key) -> String:
	return dict[key]
