""" Модуль для склейки нескольких изображений в атлас """
import math
import os
import sys

from PIL import Image


def combine(inp, output):
    """
        Собирает картинки из папки inp в файл output
        :param inp: str
        :param output: str
        :return: void
    """
    files = os.listdir(inp)
    files.sort()
    im = Image.open(inp + "/" + files[0])
    width = im.size[0]  # Определяем ширину
    height = im.size[1]  # Определяем высоту

    z = math.sqrt(len(files))
    y = round(z)
    x = math.ceil(z)
    res = Image.new("RGBA", (x*width, y*height))
    i = 0
    j = 0
    for path in files:
        im = Image.open(inp + "/" + path)
        res.paste(im, (i * width, j * height))
        if i < x-1:
            i += 1
        else:
            i = 0
            j += 1
    res.save(output)


if __name__ == "__main__":
    if len(sys.argv) == 3:
        combine(sys.argv[1], sys.argv[2])
    else:
        print("Недостаточно аргументов")
