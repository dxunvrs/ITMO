# 501595%132=127 Дни: понедельник, суббота - не уд. требованиям
# 127+8=135, 135%132=3 Дни: понедельник, четверг
# RON -> TOML
# Десериализация - RON -> объект

def deserialize() -> None:
    # открываем файл и добавляем строки в массив
    with open("schedule.ron", "r") as file:
        file_content: list = file.read().splitlines()
    # добавляем строки без отступов и однострочных комментариев в массив
    content_list: list = []
    for line in file_content:
        content_list += [delete_single_comments(line.strip())]
    # добавляем все в одну строку
    content: str = " ".join(content_list)
    # удаляем многострочные комментарии
    content = delete_multiline_comments(content)
    # заменим () на :{}
    content = content.replace("(", ":{").replace(")", "}")
    # сделаем вспомогательный массив и заодно проверим ошибки синтаксиса
    sub = create_sub_list(content)
    print(sub)
    print(content)

# удаление однострочных комментов
def delete_single_comments(s: str) -> str:
    new_line: str = ""
    for i in range(0,len(s)-1):
        if s[i]+s[i+1]=="//":
            new_line = s[:i]
            break
    else:
        new_line = s
    return new_line

# удаление многострочных комментов
def delete_multiline_comments(s: str) -> str:
    new_string = s
    for i in range(0,len(s)-1):
        if s[i]+s[i+1]=="/*":
            for j in range(i+2, len(s)-1):
                if s[j]+s[j+1]=="*/":
                    new_string = s[:i]+s[j+2:]
                    break
            else:
                raise Exception("Многострочный комментарий не завершился")
    return new_string

def create_sub_list(s: str) -> str:
    sub = ""
    for i in s:
        if i in "{}[]": sub += i
    if "[{" in sub or "}]" in s:
        raise Exception("Синтакическая ошибка, list не должен содержать этот тип данных")
    sub = sub.replace("]", "").replace("[", "")
    return sub

def create_sub_dict(s: str) -> dict:
    sub_dict = {}
    return sub_dict

if __name__ == "__main__":
    deserialize()