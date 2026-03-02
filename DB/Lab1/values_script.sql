BEGIN;
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

INSERT INTO fossils_research (fossils_age, start_date, end_date, place)
VALUES (30_000_000, '2012-01-01', '2020-01-01', 'Montana');
INSERT INTO fossils_research (fossils_age, start_date, end_date, place)
VALUES (5_000_000, '2000-01-01', '2015-01-01', 'Ethiopia');
INSERT INTO fossils_research (fossils_age, start_date, end_date, place)
VALUES (380_000_000, '2005-01-1', '2018-01-01', 'Australia');

INSERT INTO scientists_in_research (scientist_id, fossils_research_id, start_date, end_date)
VALUES (1, 1, '2012-01-01', '2019-12-20');
INSERT INTO scientists_in_research (scientist_id, fossils_research_id, start_date, end_date)
VALUES (2, 2, '2010-01-01', '2015-01-01');
INSERT INTO scientists_in_research (scientist_id, fossils_research_id, start_date, end_date)
VALUES (3, 3, '2005-01-01', '2018-01-01');
INSERT INTO scientists_in_research (scientist_id, fossils_research_id, start_date, end_date)
VALUES (1, 2, '2001-01-01', '2014-12-20');
INSERT INTO scientists_in_research (scientist_id, fossils_research_id, start_date, end_date)
VALUES (2, 3, '2006-01-01', '2007-12-20');
INSERT INTO scientists_in_research (scientist_id, fossils_research_id, start_date, end_date)
VALUES (3, 1, '2012-01-01', '2016-12-20');

INSERT INTO animal (name, era, extinction) 
VALUES ('Turtle', 'Paleogen', FALSE);
INSERT INTO animal (name, era, extinction) 
VALUES ('Ramidus', 'Miotsen', TRUE);
INSERT INTO animal (name, era, extinction) 
VALUES ('Placodermi', 'Devon', TRUE);

INSERT INTO dna_sample (organic_percentage, sex, animal_age, animal_id)
VALUES (50.32, 'M', 56, 1);
INSERT INTO dna_sample (organic_percentage, sex, animal_age, animal_id)
VALUES (60.43, 'F', 25, 1);
INSERT INTO dna_sample (organic_percentage, sex, animal_age, animal_id)
VALUES (75.66, 'M', 87, 2);
INSERT INTO dna_sample (organic_percentage, sex, animal_age, animal_id)
VALUES (75.8, 'M', 45, 2);
INSERT INTO dna_sample (organic_percentage, sex, animal_age, animal_id)
VALUES (14.23, 'F', 120, 3);

INSERT INTO dna_in_research (fossils_research_id, dna_id)
VALUES (1, 1);
INSERT INTO dna_in_research (fossils_research_id, dna_id)
VALUES (1, 2);
INSERT INTO dna_in_research (fossils_research_id, dna_id)
VALUES (2, 3);
INSERT INTO dna_in_research (fossils_research_id, dna_id)
VALUES (2, 4);
INSERT INTO dna_in_research (fossils_research_id, dna_id)
VALUES (3, 5);

INSERT INTO theory (description, proof, animal_id)
VALUES ('I have been studying the remains of Master Oogway', FALSE, 1);
INSERT INTO theory (description, proof, animal_id)
VALUES ('There are turtles today too', TRUE, 1);
INSERT INTO theory (description, proof, animal_id)
VALUES ('Ramidus the ancient ancestors of man', TRUE, 2);
INSERT INTO theory (description, proof, animal_id)
VALUES ('Placoderms became extinct due to the Ice Age', TRUE, 3);

INSERT INTO scientists_proofs (scientist_id, theory_id, result_of_research_id, date)
VALUES (1, 1, 1, '2020-02-01');
INSERT INTO scientists_proofs (scientist_id, theory_id, result_of_research_id, date)
VALUES (3, 2, 1, '2017-01-30');
INSERT INTO scientists_proofs (scientist_id, theory_id, result_of_research_id, date)
VALUES (2, 3, 2, '2015-01-01');
INSERT INTO scientists_proofs (scientist_id, theory_id, result_of_research_id, date)
VALUES (3, 4, 3, '2019-01-25');
COMMIT;