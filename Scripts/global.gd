extends Node

# Работает с настройками
# Пытается загрузить сохраненные значения при старте
# Также может сохранить настройки

# Путь к файлу с настройками
const file_path : = "user://config.json"

# Поля для хранения и считывания данных
# (чтобы в будущем не менять 2 поля сразу)
const ost_field : = "ost_vol"
const fx_field : = "fx_vol"
const vsync_field : = "vsync"
const fscreen_field : = "fullscreen"

# Объекты для проигрывания музыки
onready var ost : = $"/root/ost"
onready var fx : = $"/root/fx"

# Для того, чтобы игра знала, в какой файл сохранять данные
var loaded : = "-1"


# Создать словарь с переменными для сохранения
func gen_dict() -> Dictionary:
	var save_dict = {
		ost_field : ost.volume,
		fx_field : fx.volume,
		fscreen_field : str(OS.window_fullscreen),
		vsync_field : str(OS.vsync_enabled)
	}
	return save_dict


# Записать данные в файл
func write_settings():
	var fl = File.new()
	var state = fl.open(file_path, File.WRITE)
	assert(state == OK)
	# Сохранить словарь как JSON
	fl.store_line(to_json(gen_dict()))
	fl.close()


# Если есть ключ, то записать значение в переменную
func restore(content : Dictionary) -> void:
	# Аудио
	if content.has(ost_field):
		ost.volume = content[ost_field]
	if content.has(fx_field):
		fx.volume = content[fx_field]
	
	# Графика
	if content.has(fscreen_field):
		OS.window_fullscreen = str_to_bool(content[fscreen_field])
	if content.has(vsync_field):
		OS.vsync_enabled = str_to_bool(content[vsync_field])


# Прочитать файл с настройками
func read_settings() -> void:
	var fl = File.new()
	# Если файл существует
	if fl.file_exists(file_path):
		# Считать данные
		var state = fl.open(file_path, File.READ)
		assert(state == OK)
		var content = parse_json(fl.get_line())
		fl.close()
		# Восстановить данные
		restore(content)
	else:
		# Значения по-умолчанию
		ost.volume = 0
		fx.volume = 0
		OS.vsync_enabled = true
		OS.window_fullscreen = false


func str_to_bool(val : String) -> bool:
	if val == "True" || val == "true":
		return true
	return false


func _ready():
	# Загрузить настройки
	read_settings()

