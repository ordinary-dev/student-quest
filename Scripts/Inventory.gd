extends Node

# Inventory system

# {"item":count}
var inventory : Dictionary


func get_keys() -> Array:
	return inventory.keys()


func item_count(item : String) -> int:
	if has_item(item):
		return inventory[item]
	return 0


func remove_item(item : String) -> void:
	if has_item(item):
		if inventory[item] > 1:
			inventory[item] -= 1
		else:
			inventory.erase(item)
	NOTIFY.show("You used the " + item)
	UI.get_node("Inventory").update_inv()


func add_item(item : String) -> void:
	if has_item(item):
		inventory[item] += 1
	else:
		inventory[item] = 1
	NOTIFY.show("You got the " + item)
	UI.get_node("Inventory").update_inv()


func has_item(item : String) -> bool:
	return inventory.has(item)


func _load(inv : Dictionary) -> void:
	inventory = inv
	UI.get_node("Inventory").update_inv()
