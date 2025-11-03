# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> TOML
# Использование готовых библиотек

import pyron
import toml

def convert(file_path, output_path):
    with open(file_path, "r") as file:
        dictionary: dict = pyron.load(file_path)
        output: str = toml.dumps(dictionary)
    with open(output_path, "w") as output_file:
        output_file.write(output)

if __name__ == "__main__":
    convert("schedule.ron", "output.toml")