# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> YAML
# Сравнение времени стократного парсинга+конвертации

import time
import task1
import task2
import task3
import xml_converter

# Время для RON->YAML (моя реализация)
start_time = time.time()
for x in range(100):
    converter = task1.Converter("schedule.ron", "output_my.yaml")
    converter.convert_to_yaml()
print("My converter: ", time.time() - start_time)

# Время для RON->YAML (библиотеки)
start_time = time.time()
for x in range(100):
    converter = task2.Converter("schedule.ron", "output_library.yaml")
    converter.convert_to_yaml()
print("Library converter: ", time.time() - start_time)

# Время для RON->XML (моя реализация)
start_time = time.time()
for x in range(100):
    converter = task3.XMLConverter("schedule.ron", "output_library.xml")
    converter.convert_to_xml()
print("My XML converter ", time.time() - start_time)

# Время для RON->XML (библиотеки)
start_time = time.time()
for x in range(100):
    converter = xml_converter.XMLConverter("schedule.ron", "output_library.xml")
    converter.convert_to_xml()
print("Library XML converter ", time.time() - start_time)