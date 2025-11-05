from dicttoxml import dicttoxml, parseString
from task0 import Parser

class XMLConverter:
    parsed_object: dict = {}
    def __init__(self, file_path:str, output_path:str) -> None:
        self.output_path: str = output_path
        self.file_path: str = file_path

    def parse_file(self) -> None:
        parser: Parser = Parser(self.file_path)
        self.parsed_object = parser.parse()

    def convert_to_xml(self):
        self.parse_file()
        xml_bytes = dicttoxml(self.parsed_object, custom_root="users", attr_type=False)
        xml_pretty = parseString(xml_bytes).toprettyxml()

        with open(self.output_path, "w") as output_file:
            output_file.write(xml_pretty)

if __name__ == "__main__":
    converter: XMLConverter = XMLConverter("test.ron", "output_library.xml")
    converter.convert_to_xml()