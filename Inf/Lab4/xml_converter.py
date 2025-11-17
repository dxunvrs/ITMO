from dicttoxml import dicttoxml, parseString
from task2 import Deserializer
import pickle
import sys

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
        self.convert_to_xml()

    def convert_to_xml(self):
        xml_bytes = dicttoxml(self.parsed_object, custom_root="users", attr_type=False)
        xml_pretty = parseString(xml_bytes).toprettyxml()

        with open(self.output_path, "w") as output_file:
            output_file.write(xml_pretty)

def main():
    deserializer: Deserializer = Deserializer("schedule.ron", "output_library.bin")
    serializer: Serializer = Serializer("output_library.bin", "output_library.xml")
    deserializer.deserialize()
    serializer.serialize()

if __name__ == "__main__":
    main()