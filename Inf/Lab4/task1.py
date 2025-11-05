# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> YAML
# Сериализация - parsed_object -> YAML

from task0 import Parser

class Converter:
    def __init__(self, file_path:str, output_path:str) -> None:
        self.output_path: str = output_path
        self.file_path: str = file_path
        self.parsed_object = None
        self.content: str = ""

    def parse_file(self) -> None:
        parser: Parser = Parser(self.file_path)
        self.parsed_object = parser.parse()

    def convert_to_yaml(self) -> None:
        self.parse_file() # парсим файл кодом из предыдущего задания
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


if __name__ == "__main__":
    converter: Converter = Converter("schedule.ron", "output_my.yaml")
    converter.convert_to_yaml()
    # мой конвертер умеет в русский язык
    # converter_ru: Converter = Converter("schedule_ru.ron", "output_my.yaml")
    # converter_ru.convert_to_yaml()