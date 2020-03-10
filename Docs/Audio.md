# Аудио-система

Игра использует 2 звуковые шины: FX и OST.
Их громкость восстанавливает скрипт при старте игры. Изменить ее можно через настройки.

## Воспроизведение звука

Для воспроизведения музыки в фоне можно использовать метод `play_sound` объекта `ost`. Текущая песня заменяется новой. Функция принимает на вход `AudioStream`.

```GDScript
# Загрузить музыку из файла
sound = load("res://music.ogg")
# Начать играть ее в фоне
get_node("/root/ost").play_sound(sound)
```

Для воспроизведения коротких звуков есть объект `fx`. Он воспроизводит все звуки параллельно. Схема работы остается все той же.

```GDScript
sound = load("res://sound.wav")
get_node("/root/fx").play_sound(sound)
```

Существует отдельная функция для воспроизведения звука нажатия на кнопку, просто для удобства.

```GDScript
get_node("/root/fx").btn_click()
```

## Изменение громкости

Изменять громкость необходимо именно у шин. Код для присвоения:

```GDScript
# Установить громкость ost на value
AudioServer.set_bus_volume_db(2, value)
# Для fx
AudioServer.set_bus_volume_db(1, value)
```

## Получение громкости

```GDScript
# Сохранить в переменную громкость ost
var ost_volume = AudioServer.get_bus_volume_db(2)
# Для fx
var fx_volume = AudioServer.get_bus_volume_db(1)
```
