# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> TOML
# Десериализация - RON -> бинарный объект

import sys

class Parser:
    pos: int = 0
    content: str = ""
    content_len: int = 0
    digits: str = "0123456789"

    def __init__(self, file_path: str="", ron_string: str=""):
        if ron_string:
            self.content = ron_string
        else:
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
        elif self.char() == "(": # парсим либо структуру без имени, либо кортеж
            return self.parse_struct_without_name_or_tuple()
        elif self.char() not in " \n:./*": # парсим структуру с именем
            return self.parse_struct()
        else:
            return self.error(f"Unexpected symbol {self.char()}")

    def delete_comments(self):
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

        while "/*" in new_content:
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
        while self.content[self.pos] in " \n": # пропускаем пробелы и переносы строк
            self.pos += 1

    def char(self, a:int=0) -> str:
        return self.content[self.pos+a] # возвращаем текущий символ или символ через a

    def error(self, message:str) -> None:
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
            self.pos += 1

        if self.char() == ".": # если есть точка, то начинаем копить дробную часть
            self.pos += 1
            if self.char() not in self.digits: # если после точки не число, то выдаем ошибку
                self.error(f"Unexpected symbol {self.char()}")

            while self.char() in self.digits:
                frac_part += self.char()
                self.pos += 1

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

        while self.char() not in " \n:()[]{}/*.": # проверяем входит ли символ в допустимые символы
            name += self.char()
            self.pos += 1
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

    def parse_tuple(self) -> tuple:
        arr = []
        self.pos += 1
        self.skip_space()
        if self.char() == ")":  # проверяем пустой ли массив
            return tuple(arr)

        while True:
            element = self.parse()  # парсим значение массива
            arr.append(element)
            self.skip_space()

            if self.char() == ",":  # проверяем есть ли запятая
                self.pos += 1
                self.skip_space()
            elif self.char() == ")":  # есть ли )
                break
            else:
                self.error(f"Unexpected symbol {self.char()}")  # если неожиданный символ
        self.pos += 1
        return tuple(arr)

    def parse_struct_without_name_or_tuple(self) -> tuple | dict:
        # struct ::= () | (key: value) | (key: value, key: value, ...)
        # tuple ::= () | (value) | (value, value, ...)
        mode = "" # переменная для режима работы
        last_pos = self.pos
        self.pos += 1
        self.skip_space()

        if self.char() == ")":
            self.pos = last_pos
            return self.parse_tuple() # для условности будем возвращать пустой кортеж

        # проверим первую итерацию и если есть :, то обработаем как структуру, если нет - как кортеж
        test = self.parse()
        self.skip_space()
        if self.char() == ":":
            mode = "struct"
        elif self.char() == ",":
            mode = "tuple"
        else:
            self.error(f"Unexpected symbol {self.char()}")
        self.pos = last_pos
        if mode == "struct": # для структуры
            return self.parse_struct(mode="without_name")
        else:
            return self.parse_tuple()

    def parse_struct(self, mode="name") -> dict:
        # struct ::= Name() | Name(key: value) | Name(key: value, key: value, ...)
        name: str = ""
        if mode=="name":
            name = self.parse_name()
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

if __name__ == "__main__":
    parser = Parser(file_path="test.ron")
    print(parser.parse())