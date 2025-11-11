# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> YAML
# Сериализация - binary_object -> YAML

import sys

class Converter:
    def __init__(self, output_path:str, parsed):
        self.output_path: str = output_path
        self.parsed_object = parsed
        self.content: str = ""

    def convert_to_yaml(self) -> None:
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
        self.pos: int = 0

        with open(file_path, "r") as file:
            self.content: str = file.read()

        self.bin_arr: list = self.content.split() # создаем массив с байтами

    def byte(self) -> str: # возвращаем текущий байт
        return self.bin_arr[self.pos]

    def next_byte(self) -> None: # безопасный переход к следующему байту
        if self.pos + 1 < len(self.bin_arr):
            self.pos += 1
        else:
            self.error("Expect byte")

    def error(self, message:str) -> None: # вызов ошибок, выход из программы
        print(f"Error: {message} {self.byte()}")
        sys.exit()

    def serialize(self) -> bool | int | float | str | list | dict | None: # главный метод
        if self.byte() == f"{1:08b}":
            return self.serialize_boolean() # сериализуем булево выражение
        elif self.byte() == f"{2:08b}":
            return self.serialize_int() # сериализуем целое число
        elif self.byte() == f"{3:08b}":
            return self.serialize_float() # сериализуем число с плавающей точкой
        elif self.byte() == f"{4:08b}":
            return self.serialize_string() # сериализуем строку
        elif self.byte() == f"{5:08b}":
            return self.serialize_list() # сериализуем массив
        elif self.byte() == f"{6:08b}":
            return self.serialize_dict() # сериализуем словарь
        else:
            return self.error("Unfounded byte")

    def serialize_boolean(self) -> bool | None:
        self.next_byte()

        if self.byte() == f"{1:08b}":
            return True
        elif self.byte() == f"{0:08b}":
            return False
        else:
            return self.error("Invalid boolean byte")

    def serialize_int(self) -> int | None:
        self.next_byte()
        try:
            sign: int = int(self.byte(), 2)
        except:
            return self.error("Invalid integer sign byte")

        self.next_byte()
        try:
            if sign == 0:
                return int(self.byte(), 2)
            elif sign == 1:
                return -int(self.byte(), 2)
            else:
                return self.error("Invalid integer sign byte")
        except:
            return self.error("Invalid integer byte")

    def serialize_float(self) -> float | None:
        self.next_byte()
        try:
            sign: int = int(self.byte(), 2)
        except:
            return self.error("Invalid float sign byte")

        self.next_byte()
        try:
            int_part: int = int(self.byte(), 2)
        except:
            return self.error("Invalid integer part of float byte")

        self.next_byte()
        try:
            frac_part: int = int(self.byte(), 2)
        except:
            return self.error("Invalid fractional part of float byte")

        if sign == 0:
            return float(f"{int_part}.{frac_part}")
        elif sign == 1:
            return -float(f"{int_part}.{frac_part}")
        else:
            return self.error("Invalid float sign byte")

    def serialize_string(self) -> str | None:
        self.next_byte()

        try:
            string_len: int = int(self.byte(), 2)
        except:
            return self.error("Invalid string length byte")

        string: str = ""

        for i in range(string_len):
            self.next_byte()

            try:
                string += chr(int(self.byte(),2))
            except:
                return self.error("Invalid string char byte")

        return string

    def serialize_list(self) -> list | None:
        self.next_byte()

        try:
            arr_len: int = int(self.byte(), 2)
        except:
            return self.error("Invalid list length byte")

        arr: list = []
        for i in range(arr_len):
            self.next_byte()
            arr.append(self.serialize())

        return arr

    def serialize_dict(self) -> dict | None:
        self.next_byte()

        try:
            dictionary_len: int = int(self.byte(), 2)
        except:
            return self.error("Invalid dictionary length byte")

        dictionary: dict = {}

        for i in range(dictionary_len):
            self.next_byte()
            pair: list = self.serialize_pair()
            dictionary[pair[0]] = pair[1]

        return dictionary

    def serialize_pair(self) -> list:
        pair = [self.serialize()]
        self.next_byte()
        pair.append(self.serialize())
        return pair

if __name__ == "__main__":
    binary_serializer : BinarySerializer = BinarySerializer("output_my.bin")
    parsed_object = binary_serializer.serialize()

    converter: Converter = Converter("output_my.yaml", parsed_object)
    converter.convert_to_yaml()