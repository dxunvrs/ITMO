# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> YAML
# Десериализация - RON -> binary_object

import sys

class Parser:
    def __init__(self, file_path:str):
        self.pos: int = 0
        self.digits: str = "0123456789"
        with open(file_path, "r") as file:
            self.content = file.read()
        self.content = self.delete_comments()

    def parse(self) -> int | str | list | dict | bool | None:
        self.skip_space()

        if self.char() in self.digits+"-": # парсим число
            return self.parse_number()
        elif self.char() == '"': # парсим строку
            return self.parse_string()
        elif self.char() == "[": # парсим лист
            return self.parse_list()
        elif self.char() == "{": # парсим словарь
            return self.parse_dict()
        elif self.char() == "(": # парсим либо структуру без имени
            return self.parse_struct_or_bool(mode="unnamed")
        elif self.char() not in " \n:./*,\t": # парсим структуру с именем
            return self.parse_struct_or_bool()
        else:
            return self.error(f"Unexpected symbol {self.char()}")

    def delete_comments(self) -> str:
        new_content_list: list = []

        for line in self.content.splitlines(): # удаляем одиночные комментарии
            for i in range(len(line)-1):
                if line[i] + line[i-1] == "//":
                    new_content_list.append(line[:i-1])
                    break
            else:
                new_content_list.append(line)

        new_content: str = "\n".join(new_content_list)

        while "/*" in new_content: # пока есть начала многострочных комментариев удаляем их
            new_content = self.delete_multiline_comments(new_content)

        return new_content

    def delete_multiline_comments(self, cur_content:str) -> str:
        new_content: str = ""
        for i in range(len(cur_content)-1):
            if cur_content[i] + cur_content[i+1] == "/*":
                for j in range(i+2, len(cur_content)-1):
                    if cur_content[j] + cur_content[j+1] == "*/":
                        new_content = cur_content[:i] + cur_content[j+2:]
                        break
                else:
                    self.error("Expect */")
        return new_content

    def skip_space(self) -> None:
        while self.content[self.pos] in " \n\t": # пропускаем пробелы и переносы строк
            self.pos += 1

    def char(self, a:int=0) -> str:
        return self.content[self.pos+a] # возвращаем текущий символ

    def error(self, message:str) -> None:
        char_before: int = int(self.pos * 0.5)
        char_after: int = self.pos + int((len(self.content) - self.pos)*0.5)
        print(self.content[char_before:char_after])
        print(message)
        sys.exit()

    def parse_number(self) -> float | int:
        # number ::= x | x.x | -x | -x.x
        int_part: str = "" # переменная для целой части
        frac_part: str = "" # переменная для дробной части

        if self.char() == "-": # добавляем минус если он есть
            int_part += "-"
            self.pos += 1

        if self.char() not in self.digits: # если после минуса не число, то выдаем ошибку
            self.error(f"Unexpected symbol {self.char()}")

        while self.char() in self.digits:
            int_part += self.char() # накапливаем целую часть

            if self.pos+1 < len(self.content): # для случая если весь файл - число
                self.pos += 1
            else:
                break

        if self.char() == ".": # если есть точка, то начинаем копить дробную часть
            self.pos += 1
            if self.char() not in self.digits: # если после точки не число, то выдаем ошибку
                self.error(f"Unexpected symbol {self.char()}")

            while self.char() in self.digits:
                frac_part += self.char()

                if self.pos+1 < len(self.content): # для случая если весь файл - число
                    self.pos += 1
                else:
                    break

        if frac_part: # возвращаем результат
            return float(f"{int_part}.{frac_part}")
        return int(int_part)

    def parse_string(self) -> str:
        # string ::= "text"
        string = ""
        self.pos += 1

        while self.char() != '"':
            string += self.char()
            self.pos += 1
            if self.pos == len(self.content):
                self.error('Expect "')

        self.pos += 1
        return string

    def parse_name(self) -> str:
        name = ""

        while self.char() not in " \n:()[]{}/*.,\t": # проверяем входит ли символ в допустимые символы
            name += self.char()

            if self.pos+1 < len(self.content): # чтобы не выходило за пределы
                self.pos += 1
            else:
                break
        return name

    def parse_list(self) -> list:
        # list ::= [] | [value] | [value, value, ...]
        arr = []
        self.pos += 1
        self.skip_space()
        if self.char() == "]": # проверяем пустой ли массив
            return arr

        while True:
            element = self.parse() # парсим значение массива
            arr.append(element)
            self.skip_space()

            if self.char() == ",": # проверяем есть ли запятая
                self.pos += 1
                self.skip_space()
            elif self.char() == "]": # есть ли ]
                break
            else:
                self.error(f"Unexpected symbol {self.char()}") # если неожиданный символ
        self.pos += 1
        return arr

    def parse_struct_or_bool(self, mode:str="name") -> dict | bool:
        # struct ::= Name() | Name(key: value) | Name(key: value, key: value, ...)
        name: str = ""
        if mode=="name":
            name = self.parse_name() # так как используем parse_name(), то заодно проверим булевы выражения
            if name == "true": return True
            elif name == "false": return False
            struct = {name: {}}
        else:
            struct = {}

        self.skip_space()
        if self.char() != "(":
            self.error("Expect (")

        self.pos += 1
        self.skip_space()

        if self.char() == ")":
            return struct

        while True:
            pair = self.parse_pair()
            if mode == "name":
                struct[name][pair[0]] = pair[1]
            else:
                struct[pair[0]] = pair[1]
            self.skip_space()

            if self.char() == ",":
                self.pos += 1
                self.skip_space()
            elif self.char() == ")":
                break
            else:
                self.error(f"Unexpected symbol {self.char()}")

        self.pos += 1
        return struct

    def parse_dict(self) -> dict:
        # map :: = {} | {key: value} | {key: value, key: value, ...}
        dictionary = {}
        self.pos += 1
        self.skip_space()

        if self.char() == "}": # проверяем пустой ли словарь
            return dictionary

        while True:
            pair = self.parse_pair()
            dictionary[pair[0]] = pair[1]
            self.skip_space()

            if self.char() == ",":
                self.pos += 1
                self.skip_space()
            elif self.char() == "}":
                break
            else:
                self.error(f"Unexpected symbol {self.char()}")

        self.pos += 1
        return dictionary

    def parse_pair(self) -> list:
        pair = [] # переменная для пары ключ:значение

        if self.char() == '"': # если ключ в кавычках, то парсим как обычную строку
            pair.append(self.parse_string())
        else: # иначе как имя
            pair.append(self.parse_name())
        self.skip_space()

        if self.char() == ":":
            self.pos += 1
            self.skip_space()
            pair.append(self.parse()) # парсим значение
        else:
            self.error("Expect :")
        return pair

class BinaryDeserializer:
    def __init__(self, parsed, output_path:str):
        self.parsed_object = parsed
        self.output_path = output_path
        self.content = ""

    def deserialize(self):
        self.content = self.deserialize_value(self.parsed_object)

        with open(self.output_path, "w") as output_file:
            output_file.write(self.content)

    def deserialize_value(self, value) -> str:
        if isinstance(value, bool):
            if value:
                return f"{1:08b} {1:08b} "
            else:
                return f"{1:08b} {0:08b} "

        elif isinstance(value, int):
            if value >= 0:
                return f"{2:08b} {0:08b} {value:08b} "
            else:
                return f"{2:08b} {1:08b} {abs(value):08b} "

        elif isinstance(value, float):
            if value >= 0:
                return f"{3:08b} {0:08b} {int(value):08b} {int((value-int(value))*10**8):08b} "
            else:
                return f"{3:08b} {1:08b} {int(abs(value)):08b} {int((abs(value)-int(abs(value)))*10**8):08b} "

        elif isinstance(value, str):
            string_bytes = ""
            for char in value:
                string_bytes += f"{ord(char):08b} "
            return f"{4:08b} {len(value):08b} {string_bytes}"

        elif isinstance(value, list):
            list_bytes = f"{5:08b} {len(value):08b} "
            for element in value:
                list_bytes += self.deserialize_value(element)
            return list_bytes

        elif isinstance(value, dict):
            dict_bytes = f"{6:08b} {len(value.keys()):08b} "
            for k,v in value.items():
                dict_bytes += f"{self.deserialize_value(k)}{self.deserialize_value(v)}"
            return dict_bytes

        else:
            print("Invalid data")
            sys.exit()

if __name__ == "__main__":
    parser: Parser = Parser(file_path="schedule.ron")
    parsed_object = parser.parse()

    binary_deserializer = BinaryDeserializer(parsed_object, "output_my.bin")
    binary_deserializer.deserialize()