BEGIN;
DROP TABLE IF EXISTS university CASCADE;
DROP TABLE IF EXISTS scientist CASCADE;
DROP TABLE IF EXISTS dna CASCADE;
DROP TABLE IF EXISTS animal CASCADE;
DROP TABLE IF EXISTS fossil CASCADE;
DROP TABLE IF EXISTS fossils_research CASCADE;
DROP TABLE IF EXISTS hypothesis CASCADE;
DROP TABLE IF EXISTS hypotheses_research CASCADE;

CREATE TABLE University (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    country TEXT NOT NULL,
    city TEXT NOT NULL
);

CREATE TABLE Scientist (
    id SERIAL PRIMARY KEY,
    surname TEXT NOT NULL,
    name TEXT NOT NULL,
    university_id INTEGER NOT NULL REFERENCES university(id)
);

CREATE TABLE DNA (
    id SERIAL PRIMARY KEY,
    organic_percentage NUMERIC(5,2) CHECK(organic_percentage >= 0 AND organic_percentage <= 100)
);

CREATE TABLE Animal (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    era TEXT NOT NULL,
    extinction BOOLEAN NOT NULL,
    dna_id INTEGER REFERENCES dna(id)
);

CREATE TABLE Fossil (
    id SERIAL PRIMARY KEY,
    place TEXT NOT NULL,
    age INTEGER NOT NULL,
    animal_id INTEGER NOT NULL REFERENCES animal(id)
);

CREATE TABLE Fossils_research (
    id SERIAL PRIMARY KEY,
    scientist_id INTEGER NOT NULL REFERENCES scientist(id),
    fossil_id INTEGER NOT NULL REFERENCES fossil(id)
);

CREATE TABLE Hypothesis (
    id SERIAL PRIMARY KEY,
    animal_id INTEGER NOT NULL REFERENCES animal(id),
    proof BOOLEAN NOT NULL
);

CREATE TABLE Hypotheses_research (
    id SERIAL PRIMARY KEY,
    scientist_id INTEGER NOT NULL REFERENCES scientist(id),
    hypothesis_id INTEGER NOT NULL REFERENCES hypothesis(id)
);
COMMIT;