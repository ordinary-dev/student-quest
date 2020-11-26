extends Node

# Save values in a dictionary globally
# Copyright (c) 2020 PixelTrain
# Licensed under the GPL-3 License

var _dict: Dictionary


func is_saved(key: String) -> bool:
	return _dict.has(key)


func save(key: String, data) -> void:
	_dict[key] = data


# Returns value of the key or -1
func get(key: String):
	if _dict.has(key):
		return _dict[key]
	return "-1"


func remove_key(key: String) -> void:
	var res := _dict.erase(key)
	if res == false:
		print("[Storage]: remove_key failed")
