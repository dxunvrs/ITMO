# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> TOML
# Использование готовых библиотек

import pyron
import toml

class Converter:
    parsed_object: dict = {}
    def __init__(self, file_path:str, output_path:str) -> None:
        self.output_path: str = output_path
        self.file_path: str = file_path

    def parse_file(self):
        with open(self.file_path, "r") as file:
            self.parsed_object = pyron.load(self.file_path)

    def convert_to_toml(self):
        self.parse_file()
        with open(self.output_path, "w") as output_file:
            output: str = toml.dumps(self.parsed_object)
            output_file.write(output)

if __name__ == "__main__":
    converter = Converter("schedule.ron", "output.toml")
    converter.convert_to_toml()