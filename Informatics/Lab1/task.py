number = int(input("Введите число(в 10 СС): "))
ns = 7

def convertToNS(x):
    res = []
    n = x
    while n > 0:
        res = [n%ns] + res
        n //= ns
    return res

def convertToBalancedNS(x):
    n = abs(x)
    res = convertToNS(n)
    i = len(res)-1
    while i != -1:
        if res[i] > ns/2:
            res[i] -= ns
            res[i-1] += 1
        i -= 1
    if x < 0:
        res = [-m for m in res]
        return convertToString(res)
    return convertToString(res)

def convertToString(a):
    s = ""
    for x in a:
        if x < 0:
            s += "{^" + str(x)[1:] + "}"
        else:
            s += str(x)
    return s

print("Число в симметричной семеричной СС: ")
print(convertToBalancedNS(number))
