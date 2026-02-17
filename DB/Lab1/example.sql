SELECT surname, scientist.name, university.name, place, animal.name
FROM scientist
INNER JOIN university ON scientist.university_id = university.id
INNER JOIN fossils_research ON fossils_research.scientist_id = scientist.id
INNER JOIN fossil ON fossils_research.fossil_id = fossil.id
INNER JOIN animal ON fossil.animal_id = animal.id;