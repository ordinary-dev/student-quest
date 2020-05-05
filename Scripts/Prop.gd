extends Node

# Работает с чем угодно
# Способен загрузить это и сохранить
# user://game_id/param


# Получить параметр игры
func get(param : String, game_id : String = "null") -> String:
	# Открыть файл
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
			#NOTIFY.show("NOTEXIST")
			return "-1"
		
		# Прочитать
		var val : = fp.get_line()
		fp.close()
		return val


# Сохранить параметр игры
func save(param : String, value) -> void:
	var game_id := GLOBAL.loaded
	if game_id == "-1":
		NOTIFY.show("NOTLOADED")
		NOTIFY.show("NOTSAVED")
		return
	
	var dir : = Directory.new()
	var dir_path : = "user://" + game_id
	
	# Создать папку, если ее нет
	if not dir.dir_exists(dir_path):
		var state : = dir.make_dir(dir_path)
		assert(state == OK)
	
	# Записать значение
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
