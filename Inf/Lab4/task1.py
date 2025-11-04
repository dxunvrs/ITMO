# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> TOML
# Сериализация - parsed_object -> TOML

import sys
from task0 import Parser

class Converter:
    def __init__(self, file_path:str, output_path:str) -> None:
        self.output_path: str = output_path
        self.file_path: str = file_path
        self.parsed_object: dict = {}
        self.content: str = ""

    def parse_file(self) -> None:
        parser: Parser = Parser(self.file_path) # парсим файл кодом из предыдущего задания
        parsed_object = parser.parse()
        if isinstance(parsed_object, dict):
            self.parsed_object = parsed_object
        else:
            print("Expect dictionary")
            sys.exit(0)

    def convert_to_toml(self) -> None:
        self.parse_file()
        self.create_table(self.parsed_object) # вызываем главную функцию
        self.content = self.content.replace("True", "true").replace(":", "=").replace("False", "false")

        with open(self.output_path, "w") as output_file:
            output_file.write(self.content) # записываем результат

    def create_table(self, dictionary: dict, name="") -> None:
        keys: list = sorted(list(dictionary.keys()), key=lambda item: self.sort_key(item, dictionary))  # сортируем ключи так, чтобы словари остались в конце(для удобства)
        flag = 1  # если кроме словарей ничего нет, то не будем создавать пустую таблицу
        if all(isinstance(dictionary[key], dict) for key in keys) or len(keys) == 0:
            flag = 0
        if name and flag: # если имя непустое, то добавляем заголовок таблицы в []
            self.content += "\n" + f"[{name}]\n"

        for key in keys:
            if isinstance(dictionary[key], dict): # проверяем значение
                if name: # если есть имя, то следующее будет name.key
                    self.create_table(dictionary[key], f"{name}.{key}") # используем рекурсию
                else: # аналогично, только без имени
                    self.create_table(dictionary[key], f"{key}")
            else: # если не словарь, то записываем пару как: ключ = значение
                self.content += f"{key} = {repr(dictionary[key])} \n"

    def sort_key(self, item, dictionary) -> int: # сортировка по типу
        if isinstance(dictionary[item], dict):
            return 1
        else:
            return 0

if __name__ == "__main__":
    converter: Converter = Converter("schedule.ron", "output.toml")
    converter.convert_to_toml()