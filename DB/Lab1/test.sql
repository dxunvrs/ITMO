BEGIN;
DROP TABLE IF EXISTS university_workers CASCADE;
DROP TABLE IF EXISTS university CASCADE;
DROP TABLE IF EXISTS scientist CASCADE;

CREATE TABLE university (
    id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    short_name TEXT NOT NULL,
    country TEXT NOT NULL,
    city TEXT NOT NULL
);

CREATE TABLE scientist (
    id SERIAL PRIMARY KEY,
    surname TEXT NOT NULL,
    name TEXT NOT NULL,
    specialization TEXT NOT NULL,
    birthday DATE NOT NULL
);

CREATE TABLE university_workers (
    id SERIAL PRIMARY KEY,
    scientist_id INTEGER NOT NULL REFERENCES scientist(id),
    university_id INTEGER NOT NULL REFERENCES university(id),
    start_date DATE NOT NULL,
    end_date DATE
);

INSERT INTO university (full_name, short_name, country, city)
VALUES ('University of California, Berkeley', 'Berkeley', 'USA', 'Berkeley');
INSERT INTO university (full_name, short_name, country, city)
VALUES ('Keio University', 'Keio', 'Japan', 'Tokyo');
INSERT INTO university (full_name, short_name, country, city)
VALUES ('The Imperial College of Science, Technology and Medicine', 'Imperial College', 'UK', 'London');
INSERT INTO university (full_name, short_name, country, city)
VALUES ('Harvard University', 'Harvard', 'USA', 'Cambridge');

INSERT INTO scientist (surname, name, specialization, birthday)
VALUES ('Marshall', 'Charles', 'Paleobiology', '1961-01-02');
INSERT INTO scientist (surname, name, specialization, birthday)
VALUES ('Suwa', 'Genya', 'Paleoanthropology', '1954-02-12');
INSERT INTO scientist (surname, name, specialization, birthday)
VALUES ('Barrett', 'Paul', 'Palaeobiology', '21-09-1971');

INSERT INTO university_workers (scientist_id, university_id, start_date, end_date)
VALUES (1, 1, '2010-07-01', NULL);
INSERT INTO university_workers (scientist_id, university_id, start_date, end_date)
VALUES (2, 2, '1990-06-30', NULL);
INSERT INTO university_workers (scientist_id, university_id, start_date, end_date)
VALUES (3, 3, '2003-08-20', NULL);
INSERT INTO university_workers (scientist_id, university_id, start_date, end_date)
VALUES (1, 4, '1999-07-01', '2009-06-30');
COMMIT;