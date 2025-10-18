# Author = Shulai Roman Yurievich
# Group = P3115
# Date = 18.10.2025

# 501595 % 3 = 1

# Проблема того решение в том, что некоторые слова с окончаниями или частями окончаниями похожих
# на окончания прилагательных не различаются, напишем решение с библиотекой PyMorphy2
from Informatics_Lab3_Task3 import tests
import re
from pymorphy2 import MorphAnalyzer



def main():
    for test in tests:
        print(changeText(test[1], test[0]))
        break
        print()

def changeText(text, number):
    adjectives = findAdjectives(text)
    if len(adjectives) == 0 or number > len(adjectives):
        return "Ошибка ввода"
    newForm = createNewForm(adjectives, number)
    return changeAdjectivesForms(text, adjectives, newForm)

def findAdjectives(text):
    # ищем слова с окончаниями прилагельных
    wordPattern = r"\b([а-яё]+)(ий|ый|его|ого|ему|ому|им|ым|ем|ом|ая|яя|ей|ой|ую|юю|ое|ее|ых|ые|ыми)\b"
    words = re.findall(wordPattern, text, flags=re.IGNORECASE)

    # проверяем действительно ли они прилагательные
    morph = MorphAnalyzer()
    adjectives = []
    for word in words:
        s = word[0] + word[1]
        part = morph.parse(s)[0]
        if part.tag.POS == "ADJF":
            adjectives += [word]

    # оставляем только те, где основа встретилась 2 раза или больше, lower() используем для случая с заглавной буквой
    wordBases = [x[0].lower() for x in adjectives]
    adjectives = [x for x in adjectives if wordBases.count(x[0].lower())>1]

    return adjectives

def createNewForm(adjectives, number):
    newForm = adjectives[number-1][1] # запоминаем окончание вхождения под номером number

    return newForm

def changeAdjectivesForms(text, adjectives, newForm):
    # заменяем прилагательные с нужной основой и любым окончанием на прилагательные с нужной основой и окончанием
    changedText = re.sub(rf"\b({adjectives[0][0]})(ий|ый|его|ого|ему|ому|им|ым|ем|ом|ая|яя|ей|ой|ую|юю|ое|ее|ых|ые|ыми)\b", rf"\1{newForm}", text, flags=re.IGNORECASE)

    return changedText

if __name__ == "__main__":
    main()