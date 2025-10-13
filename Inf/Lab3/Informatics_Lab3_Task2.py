# Author = Shulai Roman Yurievich
# Group = P3115
# Date = 11.10.2025

# 501595 % 5 = 0

import re 

email1 = "students.spam@yandex.ru"
email2 = "example@example"
email3 = "example@example.com"

pattern = r"[a-zA-Z0-9._]+@([a-zA-Z]+\.[a-zA-Z]+)$"


def main():
    res = re.match(pattern, email3)
    
    if res:
        print(res.group())
    else:
        print("Fail!")

if __name__ == "__main__":
    main()