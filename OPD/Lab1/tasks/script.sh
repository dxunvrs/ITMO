mkdir ~/lab0
cd ~/lab0

touch boldore5 ducklett1 hypno5
mkdir camerupt0 pichu9 poochyena5

cd camerupt0
touch happiny spheal carvanha goldeen sunflora
mkdir toxicroak

cd ../pichu9
touch snorlax nuzleaf
mkdir voltorb

cd ../poochyena5
touch spoink
mkdir finneon drapion

cd ..

echo -e "Возможности  Overland=3 Jump=1 Power=4 Intelligence=4\nSinker=0">>boldore5
echo "Живет  Grassland Urban">>camerupt0/happiny
echo -e "Тип покемона  ICE\nWATER">>camerupt0/spheal
echo -e "Способности  Bite Leer Rage Focus Energy Scary Face\nIce Fang Screech Swagger Assurance Crunch Aqua Jet Agility Take\nDown">>camerupt0/carvanha
echo -e "Живет  Freshwater">>camerupt0/goldeen
echo -e "Ходы  After You Double-Edge\nEarth Power Endeavor Giga Drain Helping Hand Pound Seed Bomb Snore\nSynthesis Uproar Worry Seed">>camerupt0/sunflora
echo -e "Способности  Water Gun Water\nSport Defog Wing Attack Water Pulse Aerial Ace Bubblebeam Featherdance\nHurricane">>ducklett1
echo "Развитые способности  Inner Focus">>hypno5
echo -e "Тип\nпокемона  NORMAL NONE">>pichu9/snorlax
echo -e "Способности  Harden Growth Nature Power\nFake Out Torment Faint Attack Razor Wind Swagger\nExtrasensory">>pichu9/nuzleaf
echo "Развитые способности  Gluttony">>poochyena5/spoink
cd ~/lab0

chmod u=rw,g=w,o=r boldore5

chmod u=wx,g=wx,o=wx camerupt0
chmod 440 camerupt0/happiny
chmod u-rwx,g=r,o=r camerupt0/spheal
chmod 666 camerupt0/carvanha
chmod u=rw,g-rwx,o=r camerupt0/goldeen
chmod u=r,g=r,o-rwx camerupt0/sunflora
chmod u=rx,g=x,o=w camerupt0/toxicroak

chmod 444 ducklett1
chmod u=r,g=r,o-rwx hypno5

chmod 770 pichu9
chmod u-rwx,g=r,o=r pichu9/snorlax
chmod u=wx,g=rwx,o=wx pichu9/voltorb
chmod u=rw,g=w,o=r pichu9/nuzleaf

chmod 305 poochyena5
chmod u=rx,g=w,o=r poochyena5/finneon
chmod u-rwx,g-rwx,o=rw poochyena5/spoink
chmod 355 poochyena5/drapioncd ~/lab0

cp boldore5 camerupt0/happinyboldore

cat poochyena5/spoink camerupt0/happiny>boldore5_26
# ошибка: cat: poochyena5/spoink: Отказано в доступе
# выдадим право на чтение poochyena5/spoink
chmod u+r poochyena5/spoink
cat poochyena5/spoink camerupt0/happiny>boldore5_26

# право на чтение у poochyena5 и poochyena5/drapion отсутствуют, заранее выдадим их,
# чтобы увидеть результат
chmod u+r poochyena5 poochyena5/drapion

cp -r camerupt0 poochyena5/drapion
# ошибка: cp: невозможно получить доступ к 'camerupt0': Отказано в доступе
# при этом создался пустой католог camerupt0 в poochyena5/drapion, недоступный для чтения
# выдадим ему право на чтение
chmod u+r poochyena5/drapion/camerupt0
# выдадим право на чтение camerupt0
chmod u+r camerupt0
cp -r camerupt0 poochyena5/drapion
# ошибка: cp: невозможно открыть 'camerupt0/spheal' для чтения: Отказано в доступе
# выдадим право на чтение camerupt0/spheal
chmod u+r camerupt0/spheal
# добавим атрибут -n чтобы игнорировать сообщения о перезаписи
cp -rn camerupt0 poochyena5/drapion

ln boldore5 camerupt0/sphealboldore 

ln -s ~/lab0/ducklett1 camerupt0/sphealducklett

ln -s ~/lab0/poochyena5 Copy_58

cp ducklett1 camerupt0/toxicroak
# ошибка: cp: невозможно создать обычный файл 'camerupt0/toxicroak/ducklett1': Отказано в доступе
# выдадим право на запись в каталоге camerupt0/toxicroak
chmod u+w camerupt0/toxicroak
cp ducklett1 camerupt0/toxicroak

# у каталога pichu9/voltorb отсутствует право на чтение, добавим его
chmod u+r pichu9/voltorb
# покажем дерево каталогов
ls -lRi

# возвращаем все права на место
chmod u-r pichu9/voltorb
chmod u-r poochyena5/spoink
chmod u-r poochyena5 poochyena5/drapion
chmod u-r poochyena5/drapion/camerupt0
chmod u-r camerupt0
chmod u-r camerupt0/spheal
chmod u-w camerupt0/toxicroak
cd ~/lab0

mkdir tmp
wc -l camerupt0/carvanha camerupt0/goldeen camerupt0/sunflora pichu9/snorlax pichu9/nuzleaf >>tmp/out 2>>tmp/err

# опция -R выводит рекурсивно, -S сортирует по убыванию размера файлов, 2>/dev/null давит вывод ошибок, head -6,
# 6 потому что первые две строки не выводят имя файлов и/или каталогов
# есть проблема с выводом рекурсивного списка, также выводит ещё и каталоги
# идея: перенести все файлы в дополнительный каталог, там прописать ls -lS | head -4
# новая(реализованная) идея: передать ls -lR в grep с паттерном на поиск только файлов, затем в sort отсортировать по размеру(5 столбец),
# в финале head -4
# ls -lRS ./ 2>/dev/null | head -6 <- такой себе вариант
# "^-" означает что первый символ -, -k в sort сортирует по столбцу, -n - сортирует по числовому значению, -r - инверсия сортировки(от большего к меньшему)
ls -lR 2>/dev/null | grep "^-" | sort -k 5 -nr | head -4

# в $(...) записаны пути до ФАЙЛОВ(-p гарантирует это) с 5 на конце, cat выводит их содержимое, sort сортирует по a->z, cat -n нумерует строки
cat $(ls -Rp | grep "5$") | sort | cat -n

# -p добавляет к имени каталога /, конвейром перенаправляем в grep, -v инвертирует поиск, то есть все с / не будут отображены (останутся только файлы), 
# ls по умолчанию сортирует по имени, поэтому sort не нужен
# но будет ошибка(((: ls: невозможно открыть каталог 'camerupt0': Отказано в доступе
# можно выдать право на чтение camerupt0 и всё заработает
chmod u+r camerupt0
ls -p camerupt0 | grep -v /
chmod u-r camerupt0

# -R выводит рекурсивно, -utr сортирует по дате доступа(от меньшего к большему), -p добаввляет к имени каталогов /, "^d" - первый символ d, 
# .* - любые символы, [^/]$ - последний символ не / (чтобы каталоги не попались)
ls -Rutrp 2>/dev/null | grep "^d.*[^/]$" | head -3

# -R выводит рекурсивно, grep находит только файлы, следующий grep находит подстроку "ha", sort -r -k 9 сортирует по имени(z->a)
# к сожалению при отсутствии права на чтение у camerupt0 вывод пустой(
chmod u+r camerupt0
ls -lR 2>/dev/null | grep "^-" | grep "ha" | sort -r -k 9
chmod u-r camerupt0cd ~/lab0

rm -r boldore5 

rm -r camerupt0/carvanha 

rm -r camerupt0/sphealduckle* 
# ошибка: no matches found: camerupt0/sphealduckle*
# выдадим camerupt0 право на чтение
chmod u+r camerupt0
rm -r camerupt0/sphealduckle* 

rm -r camerupt0/sphealboldo* 

rm -r pichu9
# файл pichu9/snorlax защищен от записи и не удалился
# выдадим ему право на запись
chmod u+w pichu9/snorlax
rm -r pichu9

rm -r camerupt0/toxicroak
# camerupt0/toxicroak защищен от записи, также как и файл camerupt0/toxicroak/ducklett1
# выдадим им право на запись
chmod u+w camerupt0/toxicroak
chmod u+w camerupt0/toxicroak/ducklett1
rm -r camerupt0/toxicroak