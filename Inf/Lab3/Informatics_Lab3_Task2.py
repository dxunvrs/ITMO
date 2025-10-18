# Author = Shulai Roman Yurievich
# Group = P3115
# Date = 11.10.2025

# 501595 % 5 = 0

import re 


tests = ["students.spam@yandex.ru", "example@example", "example@example.com", 
        "testAdress_911@gmail.com", 
        "main.example@123yandex.com",
        "ma-in example@yitmot.com",
        "one_more-test1@mail..com",
        "123@yai.com.ru",
        "test@yai.con..ru"
]

pattern = r"[a-zA-Z0-9._]+@([a-zA-Z.]+(\.[a-zA-Z.]+)+)$"


def main():
    for test in tests:
        res = re.match(pattern, test)
        if res:
            print(f"{test} Почтовый сервис: {res[1]}")
        else:
            print(f"{test} Почтовый сервис: Fail!")
        print()

if __name__ == "__main__":
    main()