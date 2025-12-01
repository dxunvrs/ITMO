#  501595 % 2 = 1 => pandas
import pandas
from numpy import nan

data_frame = pandas.read_excel("lab5.xlsx",
                               usecols=[i for i in range(25)],
                               #skiprows=3,
                               nrows=15,
                               header=None)
data_frame = data_frame.drop(columns=data_frame.columns[5]) # удаляем столбец F
data_frame.loc[2] = nan # у меня были вспомогательные данные, поэтом удалим их

styled_df =  data_frame.style # применяем стиль к data_frame

def set_border(side: str, index: int, col: int): # функция для добавления границы к ячейке
    global styled_df

    styled_df.set_properties(
        **{f"border-{side}": "2px solid blue"},
        subset=(styled_df.index[index], styled_df.columns[col])
    )

# добавляем границы
for row in range(len(data_frame.index)):
    for column in range(len(data_frame.columns)):
        if column in [0,1,2,3] and row >= 3:
            set_border("left", row, column)
            if row == 3:
                set_border("top", row, column)
            if row == 14:
                set_border("bottom", row, column)
        elif column == 4 and row >=3 :
            set_border("right", row, column)
            if row == 3:
                set_border("top", row, column)
            if row == 14:
                set_border("bottom", row, column)
        elif column > 4 and row >= 3:
            if row == 3:
                set_border("top", row, column)
            if row == 14:
                set_border("bottom", row, column)
            if column == len(styled_df.columns)-1:
                set_border("right", row, column)

styled_df.to_excel("Output.xlsx", index=False, header=False)