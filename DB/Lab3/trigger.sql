-- 1. Создаем триггерную функцию
CREATE OR REPLACE FUNCTION check_research_is_active()
RETURNS TRIGGER AS $$
DECLARE
    research_end_date DATE;
BEGIN
    -- Получаем дату окончания исследования из таблицы fossils_research
    SELECT end_date INTO research_end_date
    FROM fossils_research
    WHERE id = NEW.fossils_research_id;

    -- Если дата окончания заполнена и она уже прошла
    IF research_end_date IS NOT NULL AND research_end_date < CURRENT_DATE THEN
        IF TG_OP = 'INSERT' THEN
            RAISE EXCEPTION 'Нельзя добавить ученого: исследование (ID %) уже завершено %', 
                NEW.fossils_research_id, research_end_date;
        ELSIF TG_OP = 'UPDATE' THEN
            RAISE EXCEPTION 'Нельзя изменить исследование ученого: новое исследование (ID %) уже завершено %', 
                NEW.fossils_research_id, research_end_date;
        END IF;
    END IF;

    -- Если всё хорошо, разрешаем вставку
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. Создаем сам триггер
CREATE TRIGGER tr_prevent_join_closed_research
BEFORE INSERT OR UPDATE ON scientists_in_research
FOR EACH ROW
EXECUTE FUNCTION check_research_is_active();
