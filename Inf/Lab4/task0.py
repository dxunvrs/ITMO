# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> YAML
# Десериализация - RON -> binary_object

import sys
import pickle

class Parser:
    pos: int = 0
    content: str = ""
    content_len: int = 0
    digits: str = "0123456789"

    def __init__(self, file_path:str) -> None:
        with open(file_path, "r") as file:
            self.content = file.read()
        self.delete_comments()

    def parse(self):
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

    def delete_comments(self) -> None:
        new_content = ""
        new_content_list = []

        for line in self.content.splitlines(): # удаляем одиночные комментарии
            for i in range(len(line)-1):
                if line[i] + line[i-1] == "//":
                    new_content_list.append(line[:i-1])
                    break
            else:
                new_content_list.append(line)

        new_content = "\n".join(new_content_list)

        while "/*" in new_content: # пока есть начала многострочных комментариев удаляем их
            new_content = self.delete_multiline_comments(new_content)

        self.content = new_content
        self.content_len = len(new_content)

    def delete_multiline_comments(self, cur_content:str) -> str:
        new_content = ""
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
        error_string: str = ""
        char_before: int = int(self.pos * 0.5)
        char_after: int = self.pos + int((self.content_len - self.pos)*0.5)
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

            if self.pos+1 < self.content_len: # для случая если весь файл - число
                self.pos += 1
            else:
                break

        if self.char() == ".": # если есть точка, то начинаем копить дробную часть
            self.pos += 1
            if self.char() not in self.digits: # если после точки не число, то выдаем ошибку
                self.error(f"Unexpected symbol {self.char()}")

            while self.char() in self.digits:
                frac_part += self.char()

                if self.pos+1 < self.content_len: # для случая если весь файл - число
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
            if self.pos == self.content_len:
                self.error('Expect "')

        self.pos += 1
        return string

    def parse_name(self) -> str:
        name = ""

        while self.char() not in " \n:()[]{}/*.,\t": # проверяем входит ли символ в допустимые символы
            name += self.char()

            if self.pos+1 < self.content_len: # чтобы не выходило за пределы
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
    types = {"bool":1,
             "int": 2,
             "float": 3,
             "string": 4,
             "list": 5,
             "dict": 6
             }

    def __init__(self, parsed_object, output_path:str):
        self.parsed_object = parsed_object
        self.output_path = output_path
        self.content = ""

    def deserialize(self):
        self.content = self.deserialize_value(self.parsed_object)

        with open(self.output_path, "w") as output_file:
            output_file.write(self.content)

    def deserialize_value(self, value) -> str:
        if isinstance(value, bool):
            if value:
                return f"{self.types['bool']:08b} {1:08b} "
            else:
                return f"{self.types['bool']:08b} {0:08b} "
        elif isinstance(value, int):
            # int_bytes = f"{value:b}"
            return f"{self.types['int']:08b} {value:08b} "
        #elif isinstance(value, float):
            #return f"{self.types['float']}{int(value):08x}{int((value-int(value))):08x}"
        elif isinstance(value, str):
            string_bytes = ""
            for char in value:
                # string_bytes += str(ord(char)) + " "
                string_bytes += f"{ord(char):08b} "
            return f"{self.types['string']:08b} {len(value):08b} {string_bytes}"
        elif isinstance(value, list):
            list_bytes = f"{self.types['list']:08b} {len(value):08b} "
            for element in value:
                list_bytes += self.deserialize_value(element)
            return list_bytes
        elif isinstance(value, dict):
            dict_bytes = f"{self.types['dict']:08b} {len(value.keys()):08b} "
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
    #print(' '.join(format(ord(x), 'b') for x in "абоба"))
    #print(f"{123:b}")