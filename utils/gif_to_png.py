""" Модуль для разделения gif """
from PIL import Image
import sys


def convert_gif(inp, output):
    """
        Конвертирует gif из inp в последовательность output%d.png
        %d - порядковый номер кадра
        :param inp: str
        :param output: str
        :return: void
    """
    im = Image.open(inp)

    i = 0
    try:
        while 1:
            im.save(output + '%d.png' % i)
            i += 1
            im.seek(i)
    except EOFError:
        print("Done")


if __name__ == "__main__":
    if len(sys.argv) == 3:
        convert_gif(sys.argv[1], sys.argv[2])
    else:
        print("Недостаточно аргументов")
