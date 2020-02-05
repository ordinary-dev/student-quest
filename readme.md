# Student Quest
Проект игры на движке `Godot`

### Как создать `.apk`?
1. Установить `openjdk`
2. Установить `adb`
3. Настроить `godot`

### Структура игры:
```
root
- global
- ost
- fx
- scene
```

`fx` используется для воспроизведения коротких звуков, например, нажатия на кнопки.

`ost` используется для фонового воспроизведения музыки.

`global` считывает основные параметры и хранит их в памяти, а также способен сохранить их в файл.

Для сохранения прогресса используются файлы `save.n.txt`, где `n` - номер игры. Все номера есть в `global` в массиве `saved_games`.

Громкость `fx` и `ost` также задается через параметры в `global`.

### Полезные ссылки:
* [Google Docs](https://docs.google.com/document/d/1qERKAdkpZH27V4oyoe7L1V3VZTVXUXmb6nJv103BRSE/edit)
* [Godot Engine](https://godotengine.org/download)

