extends Node

# Save values in a dictionary globally
# Avaiable at /root/temp

var dict : Dictionary


func is_saved(key:String) -> bool:
	return dict.has(key)


func save(key:String, data) -> void:
	dict[key] = data


func get(key):
	return dict[key]


func remove_key(key) -> void:
	dict.erase(key)
