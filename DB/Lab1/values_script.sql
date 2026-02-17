BEGIN;
INSERT INTO university (name, country, city) 
VALUES ('UC Berkeley', 'USA', 'Berkeley');
INSERT INTO university (name, country, city)
VALUES ('Keio University', 'Japan', 'Tokyo');
INSERT INTO university (name, country, city)
VALUES ('Imperial College London', 'UK', 'London');

INSERT INTO scientist (surname, name, university_id)
VALUES ('Marshall', 'Charles', 1);
INSERT INTO scientist (surname, name, university_id)
VALUES ('Suwa', 'Genya', 2);
INSERT INTO scientist (surname, name, university_id)
VALUES ('Barrett', 'Paul', 3);

INSERT INTO dna (organic_percentage)
VALUES (50);
INSERT INTO dna (organic_percentage)
VALUES (75);
INSERT INTO dna (organic_percentage)
VALUES (20);

INSERT INTO animal (name, era, extinction, dna_id)
VALUES ('Turtle', 'Paleogen', FALSE, 1);
INSERT INTO animal (name, era, extinction, dna_id)
VALUES ('Ramidus', 'Miotsen', TRUE, 2);
INSERT INTO animal (name, era, extinction, dna_id)
VALUES ('Placodermi', 'Devon', TRUE, 3);

INSERT INTO fossil (place, age, animal_id)
VALUES ('Montana', 30000000, 1);
INSERT INTO fossil (place, age, animal_id)
VALUES ('Ethiopia', 5000000, 2);
INSERT INTO fossil (place, age, animal_id)
VALUES ('Australia', 380000000, 3);

INSERT INTO fossils_research (scientist_id, fossil_id)
VALUES (1, 1);
INSERT INTO fossils_research (scientist_id, fossil_id)
VALUES (2, 2);
INSERT INTO fossils_research (scientist_id, fossil_id)
VALUES (3, 3);
INSERT INTO fossils_research (scientist_id, fossil_id)
VALUES (1, 2);
INSERT INTO fossils_research (scientist_id, fossil_id)
VALUES (2, 3);
INSERT INTO fossils_research (scientist_id, fossil_id)
VALUES (3, 1);

INSERT INTO hypothesis (animal_id, proof)
VALUES (1, TRUE);
INSERT INTO hypothesis (animal_id, proof)
VALUES (1, FALSE);
INSERT INTO hypothesis (animal_id, proof)
VALUES (2, FALSE);
INSERT INTO hypothesis (animal_id, proof)
VALUES (3, FALSE);

INSERT INTO hypotheses_research (scientist_id, hypothesis_id)
VALUES (1, 1);
INSERT INTO hypotheses_research (scientist_id, hypothesis_id)
VALUES (1, 2);
INSERT INTO hypotheses_research (scientist_id, hypothesis_id)
VALUES (2, 2);
INSERT INTO hypotheses_research (scientist_id, hypothesis_id)
VALUES (2, 3);
INSERT INTO hypotheses_research (scientist_id, hypothesis_id)
VALUES (3, 3);
INSERT INTO hypotheses_research (scientist_id, hypothesis_id)
VALUES (3, 1);
COMMIT;