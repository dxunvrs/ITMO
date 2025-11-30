#  501595 % 2 = 1 => pandas
import pandas

from openpyxl import load_workbook
from openpyxl.styles import Border, Side

data_frame = pandas.read_excel("lab5.xlsx",
                               usecols=[i for i in range(25)],
                               skiprows=2,
                               nrows=12)
data_frame = data_frame.drop(columns=data_frame.columns[5]) # удаляем столбец F

print(data_frame)