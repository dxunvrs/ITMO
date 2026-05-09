DROP INDEX IF EXISTS idx_люди_фамилия;
DROP INDEX IF EXISTS idx_ведомости_ид;
DROP INDEX IF EXISTS idx_ведомости_члвк_ид;
DROP INDEX IF EXISTS idx_ведомости_covering;
DROP INDEX IF EXISTS idx_люди_отчество;
DROP INDEX IF EXISTS idx_сессия_сэс_ид;
DROP INDEX IF EXISTS idx_ведомости_дата;

-- Запрос 1. Вариант 1
CREATE INDEX idx_люди_фамилия ON Н_ЛЮДИ(ФАМИЛИЯ); -- для быстрой фильтрации
CREATE INDEX idx_ведомости_члвк_ид ON Н_ВЕДОМОСТИ(ЧЛВК_ИД); -- для быстрого соединения
CREATE INDEX idx_ведомости_ид ON Н_ВЕДОМОСТИ(ИД); -- для быстрой фильтрации

-- Запрос 1. Вариант 2
CREATE INDEX idx_ведомости_covering ON Н_ВЕДОМОСТИ(ЧЛВК_ИД, ИД, ДАТА);
CREATE INDEX idx_люди_фамилия ON Н_ЛЮДИ(ФАМИЛИЯ);

-- Запрос 2. Вариант 1
CREATE INDEX idx_люди_отчество ON Н_ЛЮДИ(ОТЧЕСТВО); -- для быстрой фильтрации
CREATE INDEX idx_ведомости_члвк_ид ON Н_ВЕДОМОСТИ(ЧЛВК_ИД); -- для быстрого соединения
CREATE INDEX idx_ведомости_дата ON Н_ВЕДОМОСТИ(ДАТА); -- для быстрой фильтрации
CREATE INDEX idx_сессия_сэс_ид ON Н_СЕССИЯ(СЭС_ИД); -- для быстрого соединения

-- Запрос 2. Вариант 2
CREATE INDEX idx_ведомости_covering ON Н_ВЕДОМОСТИ(ЧЛВК_ИД, ДАТА, СЭС_ИД);
CREATE INDEX idx_люди_отчество ON Н_ЛЮДИ(ОТЧЕСТВО); 
CREATE INDEX idx_сессия_сэс_ид ON Н_СЕССИЯ(СЭС_ИД);