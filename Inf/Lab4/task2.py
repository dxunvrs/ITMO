# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> YAML
# Использование готовых библиотек

import sys
import pyron
import yaml
import pickle

class Deserializer:
    def __init__(self, file_path:str, bin_path:str):
        self.file_path = file_path
        self.bin_path = bin_path
        self.parsed_object = None

    def parse(self):
        try:
            self.parsed_object = pyron.load(self.file_path)
        except Exception as e:
            print(e)
            sys.exit()

    def deserialize(self):
        self.parse()
        with open(self.bin_path, "wb") as bin_file:
            try:
                # print(pickle.dumps(self.parsed_object))
                pickle.dump(self.parsed_object, bin_file)
            except Exception as e:
                print(e)
                sys.exit()

class Serializer:
    def __init__(self, bin_path:str, output_path:str):
        self.bin_path = bin_path
        self.output_path = output_path
        self.parsed_object = None

    def serialize(self):
        with open(self.bin_path, "rb") as bin_file:
            try:
                self.parsed_object = pickle.load(bin_file)
            except Exception as e:
                print(e)
                sys.exit()
        self.convert_to_yaml()

    def convert_to_yaml(self):
        with open(self.output_path, "w") as output_file:
            try:
                output_file.write(yaml.dump(self.parsed_object))
            except Exception as e:
                print(e)
                sys.exit()

def main():
    deserializer: Deserializer = Deserializer("schedule.ron", "output_library.bin")
    serializer: Serializer = Serializer("output_library.bin", "output_library.yaml")
    deserializer.deserialize()
    serializer.serialize()

if __name__ == "__main__":
    main()