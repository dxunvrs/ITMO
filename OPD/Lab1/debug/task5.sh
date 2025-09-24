# для лабы ~/lab0
cd ~/Study/OPD/Lab1/lab0

rm -r boldore5 

rm -r camerupt0/carvanha 

rm -r camerupt0/sphealduckle* 
# ошибка: no matches found: camerupt0/sphealduckle*
# выдадим camerupt0 право на чтение
chmod u+r camerupt0
rm -r camerupt0/sphealduckle* 

rm -r camerupt0/sphealboldo* 

rm -rf pichu9
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