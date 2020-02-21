extends Node

# Общая функция для смены сцен.
# Позже можно добавить анимацию, изменив лишь эту функцию,
# Не затрагивая множество разных скриптов
func load_scene(scene_name : String) -> void:
	assert(get_tree().change_scene(scene_name) == OK)
