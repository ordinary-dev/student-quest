# Сцены
В игре есть объект, который отвечает за загрузку сцен. Он создан для того, чтобы управлять не только переключением сцен, но и анимациями перехода.

## Простая загрузка сцены
Ниже приведен пример смены сцены с анимацией затухания и появления.

```GDScript
var scene_path = "res://scene.tscn"
get_node("/root/scene_loader").load_scene(scene_path)
```

## Отключение анимаций
Для этого используются параметры `anim_start` и `anim_end`. По-умолчанию они равны `true`.

```GDScript
# Отключить анимацию появления
get_node("/root/scene_loader").load_scene(scene_path, true, false)
```

```GDScript
# Отключить все анимации
get_node("/root/scene_loader").load_scene(scene_path, false, false)
```
