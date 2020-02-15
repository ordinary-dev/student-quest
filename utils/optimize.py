""" Модуль для упрощения изображений """
from PIL import Image
import sys


def combine(inp, output):
    """
        Считает количество реальных пикселей и изменяет размер
        :param inp: str
        :param output: str
        :return: void
    """
    im = Image.open(inp)
    width = im.size[0]  # Определяем ширину
    height = im.size[1]  # Определяем высоту
    print(str(width) + "x" + str(height))
    pix = im.load()
    x = 1
    y = 1

    for i in range(1, width):
        b = False
        # для каждого ряда, начиная с 1
        for j in range(height):
            # для каждого пикселя ряда
            if pix[i, j] != pix[i-1, j]:
                b = True
                break
        if b:
            x += 1

    for j in range(1, height):
        b = False
        # для каждого ряда, начиная с 1
        for i in range(width):
            # для каждого пикселя ряда
            if pix[i, j] != pix[i, j-1]:
                b = True
                break
        if b:
            y += 1

    im = im.resize((x, y))
    print(str(x) + "x" + str(y))
    im.save(output)


if __name__ == "__main__":
    if len(sys.argv) == 3:
        combine(sys.argv[1], sys.argv[2])
    else:
        print("Недостаточно аргументов")
