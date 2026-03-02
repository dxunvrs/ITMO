BEGIN;
DROP TABLE IF EXISTS university CASCADE;
DROP TABLE IF EXISTS scientist CASCADE;
DROP TABLE IF EXISTS university_workers CASCADE;
DROP TABLE IF EXISTS fossils_research CASCADE;
DROP TABLE IF EXISTS scientists_in_research CASCADE;
DROP TABLE IF EXISTS animal CASCADE;
DROP TABLE IF EXISTS dna_sample CASCADE;
DROP TABLE IF EXISTS dna_in_research CASCADE;
DROP TABLE IF EXISTS theory CASCADE;
DROP TABLE IF EXISTS scientists_proofs CASCADE;

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

CREATE TABLE fossils_research (
    id SERIAL PRIMARY KEY,
    fossils_age INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    place TEXT NOT NULL
);

CREATE TABLE scientists_in_research (
    id SERIAL PRIMARY KEY,
    scientist_id INTEGER NOT NULL REFERENCES scientist(id),
    fossils_research_id INTEGER NOT NULL REFERENCES fossils_research(id),
    start_date DATE NOT NULL,
    end_date DATE
);

CREATE TABLE animal (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    era TEXT NOT NULL,
    extinction BOOLEAN NOT NULL
);

CREATE TABLE dna_sample (
    id SERIAL PRIMARY KEY,
    organic_percentage NUMERIC(5,2) CHECK (organic_percentage >= 0 AND organic_percentage <= 100),
    sex CHAR(1) NOT NULL CHECK (sex IN ('M', 'F')),
    animal_age INTEGER NOT NULL,
    animal_id INTEGER NOT NULL REFERENCES animal(id)
);

CREATE TABLE dna_in_research (
    id SERIAL PRIMARY KEY,
    fossils_research_id INTEGER NOT NULL REFERENCES fossils_research(id),
    dna_id INTEGER NOT NULL REFERENCES dna_sample(id)
);

CREATE TABLE theory (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    proof BOOLEAN NOT NULL,
    animal_id INTEGER NOT NULL REFERENCES animal(id)

);

CREATE TABLE scientists_proofs (
    id SERIAL PRIMARY KEY,
    scientist_id INTEGER NOT NULL REFERENCES scientist(id),
    theory_id INTEGER NOT NULL REFERENCES theory(id),
    result_of_research_id INTEGER NOT NULL REFERENCES fossils_research(id),
    date DATE NOT NULL
);
COMMIT;