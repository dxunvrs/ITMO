# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> YAML
# Сериализация - binary_object -> YAML
import sys

from task0 import Parser

class Converter:
    def __init__(self, output_path:str, parsed_object):
        self.output_path: str = output_path
        self.parsed_object = parsed_object
        self.content: str = ""

    # def parse_file(self) -> None:
    #     parser: Parser = Parser(self.file_path)
    #     self.parsed_object = parser.parse()

    def convert_to_yaml(self) -> None:
        # self.parse_file() # парсим файл кодом из предыдущего задания
        self.content = self.create_tree(self.parsed_object, "") # вызываем главный метод

        with open(self.output_path, "w") as output_file:
            output_file.write(self.content) # сохраняем результат

    def create_tree(self, value, name, level=0) -> str:
        spaces = " " * level # определяем отступ

        if isinstance(value, dict): # если словарь
            if name == "": # в случае первого прохода
                lines = []
            else:
                lines = [f"{spaces}{name}:"]
            for k,v in value.items():
                lines.append(self.create_tree(v,k,level+1)) # рекурсивно спускаемся по элементам, в качестве имени передаем ключ
            return "\n".join(lines)
        elif isinstance(value, list): # если массив
            if name == "":
                lines = []
            else:
                lines = [f"{spaces}{name}:"]
            for item in value:
                lines.append(self.create_tree(item, "-", level+1)) # рекурсивно спускаемся по элементам, в качестве имени передаем -
            return "\n".join(lines)
        else:
            if name == "-": # если это элемент массива, то ставим -
                return f"{spaces}{name} {value}"
            if name == "": # если ничего нет, значит ставим просто значение
                return f"{spaces}{value}"
            return f"{spaces}{name}: {value}" # иначе вывод key: value

class BinarySerializer:
    def __init__(self, file_path):
        self.pos = 0

        with open(file_path, "r") as file:
            self.content: str = file.read()
        self.bin_arr: list = self.content.split()

    def byte(self) -> str:
        return self.bin_arr[self.pos]

    def error(self):
        print("Error")
        sys.exit()

    def serialize(self):
        if self.byte() == f"{1:08b}":
            return self.serialize_boolean()
        elif self.byte() == f"{2:08b}":
            return self.serialize_int()

    def serialize_boolean(self):
        self.pos += 1
        if self.byte() == f"{1:08b}":
            return True
        elif self.byte() == f"{0:08b}":
            return False
        else:
            self.error()

    def serialize_int(self):
        self.pos += 1

        return int(self.byte(), 2)

    def serialize_float(self):
        pass

    def serialize_string(self):
        pass

    def serialize_list(self):
        pass

    def serialize_dict(self):
        pass

if __name__ == "__main__":
    binary_serializer : BinarySerializer = BinarySerializer("output_my.bin")
    parsed_object = binary_serializer.serialize()
    converter: Converter = Converter("output_my.yaml", parsed_object)
    converter.convert_to_yaml()
    # мой конвертер умеет в русский язык
