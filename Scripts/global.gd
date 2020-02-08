extends Node

# Объекты для проигрывания музыки
onready var ost : = $"/root/ost"
onready var fx : = $"/root/fx"

# Путь к файлу с настройками
var file_name : = "user://save_game.dat"

# Поля для хранения и считывания данных
# (чтобы в будущем не менять 2 поля сразу)
var ost_field : = "ost_vol"
var fx_field : = "fx_vol"
var sg_field : = "saved_games"

# Все файлы с сохранениями игр названы user://save.<номер>.txt
var saved_games : = []

# Для того, чтобы игра знала, в какой файл сохранять данные
var loaded : = 0

# Обновить информацию об этапе для файла сохранения игры
func upd_stage(stage : int) -> void:
	var fl : = File.new()
	fl.open("user://save." + str(loaded) + ".txt", File.WRITE)
	fl.store_line(to_json({"stage":stage}))
	fl.close()

# Создать словарь с переменными для сохранения
func gen_dict() -> Dictionary:
	var save_dict = {
		ost_field:AudioServer.get_bus_volume_db(2),
		fx_field:AudioServer.get_bus_volume_db(1),
		sg_field:saved_games
	}
	return save_dict

# Записать данные в файл
func write_file(path : String = file_name):
	var fl = File.new()
	fl.open(path, File.WRITE)
	# Сохранить словарь как JSON
	fl.store_line(to_json(gen_dict()))
	fl.close()

func restore(content : Dictionary) -> void:
	# Если есть ключ, то записать значение в переменную
	if content.has(ost_field):
		AudioServer.set_bus_volume_db(2, content[ost_field])
	if content.has(fx_field):
		AudioServer.set_bus_volume_db(1, content[fx_field])
	if content.has(sg_field):
		saved_games = content[sg_field]

# Прочитать файл с настройками
func read_file(path : String = file_name) -> void:
	var fl = File.new()
	# Если файл существует
	if fl.file_exists(path):
		# Считать данные
		fl.open(path, File.READ)
		var content = parse_json(fl.get_line())
		fl.close()
		# Восстановить данные
		restore(content)
	else:
		# Значения по-умолчанию
		AudioServer.set_bus_volume_db(1, 0)
		AudioServer.set_bus_volume_db(2, 0)


func _ready():
	# Загрузить настройки
	read_file()

