# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> YAML
# Сериализация - RON -> XML

from task1 import BinarySerializer

class XMLConverter:
    def __init__(self, output_path:str, parsed):
        self.output_path: str = output_path
        self.parsed_object = parsed
        self.content: str = ""

    def convert_to_xml(self):
        self.content = self.create_tree(self.parsed_object, "root") # вызываем главную функцию

        with open(self.output_path, "w") as output_file:
            output_file.write(self.content) # сохраняем результат

    def create_tree(self, value, tag, level=0) -> str:
        spaces = "    " * level # определяем отступ
        if self.is_float(tag): cur_tag = f"n{tag}" # тэг не может быть числом
        else: cur_tag = tag

        if isinstance(value, dict): # если словарь
            lines = [f"{spaces}<{cur_tag}>"]
            for k, v in value.items():
                lines.append(self.create_tree(v, k, level+1)) # рекурсивно спускаемся по элементам, в качестве тэга передаем ключ
            lines.append(f"{spaces}</{cur_tag}>") # завершение блока
            return "\n".join(lines) # соединяем строки в одну

        elif isinstance(value, list): # если массив
            lines = [f"{spaces}<{cur_tag}>"]
            for item in value:
                lines.append(self.create_tree(item, "item", level+1)) # рекурсивно спускаемся по элементам, <item> в качестве тэга для каждого элемента
            lines.append(f"{spaces}</{cur_tag}>")
            return "\n".join(lines) # соединяем строки в одну

        else:
            return f"{spaces}<{cur_tag}>{str(value)}</{cur_tag}>" # в других случаях просто записываем значение

    def is_float(self, string:str) -> bool:
        try:
            float(string)
            return True
        except:
            return False

def main():
    binary_serializer: BinarySerializer = BinarySerializer("output_my.bin")
    parsed_object = binary_serializer.serialize()
    xml_converter: XMLConverter = XMLConverter("output_my.xml", parsed_object)

if __name__ == "__main__":
    main()