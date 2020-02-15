# coding=utf-8
""" Модуль для обрезки прозрачных краев """
from PIL import Image
import sys


def crop(inp, output):
    """
        Удаляет прозрачные строчки и ряды
        :param inp: str
        :param output: str
        :return: void
    """
    im = Image.open(inp)

    # Подготовка
    width = im.size[0]  # Определяем ширину
    height = im.size[1]  # Определяем высоту
    pix = im.load()

    # Проверить каждую строчку сверху
    count = 0
    for i in range(height):
        rem = True
        for j in range(width):
            if pix[j, i][3] != 0:   # если пиксель не прозрачный
                rem = False
                break
        if rem:
            count += 1
        else:
            break
    im = im.crop((0, count, width, height))

    # Обновить данные
    height = im.size[1]  # Обновляем высоту
    pix = im.load()

    # Проверить каждую строчку снизу
    count = 0
    for i in range(height-1, 0, -1):
        rem = True
        for j in range(width):
            if pix[j, i][3] != 0:  # если пиксель не прозрачный
                rem = False
                break
        if rem:
            count += 1
        else:
            break
    im = im.crop((0, 0, width, height-count))

    # Обновить данные
    height = im.size[1]  # Обновляем высоту
    pix = im.load()

    # Проверить каждый ряд слева
    count = 0
    for j in range(width):
        rem = True
        for i in range(height):
            if pix[j, i][3] != 0:  # если пиксель не прозрачный
                rem = False
                break
        if rem:
            count += 1
        else:
            break
    im = im.crop((count, 0, width, height))

    # Обновить данные
    width = im.size[0]  # Обновляем ширину
    pix = im.load()

    # Проверить каждый ряд справа
    count = 0
    for j in range(width-1, 0, -1):
        rem = True
        for i in range(height):
            if pix[j, i][3] != 0:  # если пиксель не прозрачный
                rem = False
                break
        if rem:
            count += 1
        else:
            break
    im = im.crop((0, 0, width-count, height))

    # Сохранить результат
    im.save(output)


if __name__ == "__main__":
    if len(sys.argv) == 3:
        crop(sys.argv[1], sys.argv[2])
    else:
        print("Недостаточно аргументов")
