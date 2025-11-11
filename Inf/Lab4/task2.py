# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> YAML
# Использование готовых библиотек

import pyron
import yaml

class Converter:
    parsed_object: dict = {}
    def __init__(self, file_path:str, output_path:str):
        self.output_path: str = output_path
        self.file_path: str = file_path

    def parse_file(self):
        with open(self.file_path, "r") as file:
            try:
                self.parsed_object = pyron.load(self.file_path)
            except Exception as error:
                print(error)

    def convert_to_yaml(self):
        self.parse_file()
        with open(self.output_path, "w") as output_file:
            output: str = yaml.dump(self.parsed_object)
            output_file.write(output)

if __name__ == "__main__":
    converter: Converter = Converter("schedule.ron", "output_library.yaml")
    converter.convert_to_yaml()