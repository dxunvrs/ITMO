from dicttoxml import dicttoxml, parseString
from task0 import Parser

def convert_to_xml():
    parser: Parser = Parser("schedule.ron")
    parsed_object = parser.parse()

    xml_bytes = dicttoxml(parsed_object, custom_root='users', attr_type=False)
    xml_pretty = parseString(xml_bytes).toprettyxml()

    with open("output.xml", "w") as file:
        file.write(xml_pretty)

if __name__ == "__main__":
    convert_to_xml()