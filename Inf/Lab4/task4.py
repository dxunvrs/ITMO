# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> YAML
# Сравнение времени стократного парсинга+конвертации

import time

import task0
import task1
import task2
import task3
import xml_converter

# Время для RON->YAML (моя реализация)
start_time = time.time()
for x in range(100):
    task0.main()
    task1.main()
print("My converter: ", time.time() - start_time)

# Время для RON->YAML (библиотеки)
start_time = time.time()
for x in range(100):
    task2.main()
print("Library converter: ", time.time() - start_time)

# Время для RON->XML (моя реализация)
start_time = time.time()
for x in range(100):
    task0.main()
    task3.main()
print("My XML converter ", time.time() - start_time)

# Время для RON->XML (библиотеки)
start_time = time.time()
for x in range(100):
    xml_converter.main()
print("Library XML converter ", time.time() - start_time)