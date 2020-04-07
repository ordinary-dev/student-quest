extends Node

# Обработчик событий
# Может получать названия событий 
# и нужную сцену для загрузки


# Получить содержимое файла события
func get_event_info(event : String) -> Dictionary:
	var fp = File.new()
	var state = fp.open("res://Events/" + event + ".json", File.READ)
	assert(state == OK)
	var tmp = fp.get_line()
	var dict = parse_json(tmp)
	fp.close()
	return dict


# Получить только имя
func get_event_name(event : String) -> String:
	return get_event_info(event)["name"]


# Получить только сцену
func get_event_scene(event : String) -> String:
	return get_event_info(event)["scene"]
