/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';
SELECT name FROM animals WHERE neutered = 'true' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = 'true';
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT deletebydateofbirth;
UPDATE animals SET weight_kg = (weight_kg*-1);
ROLLBACK TO deletebydateofbirth;
UPDATE animals SET weight_kg = weight_kg*(-1) WHERE weight_kg < 0;
COMMIT;

SELECT COUNT (*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MAX(weight_kg) AS maximum_weight, MIN(weight_kg) AS minimum_weight FROM animals GROUP BY species;

SELECT species, ROUND(AVG(escape_attempts), 2) AS average_escape_attempts FROM animals WHERE date_of_birth >= '1990-01-01' AND date_of_birth < '2000-12-31' GROUP BY species;

SELECT full_name, name FROM owner JOIN animals ON owner.id = animals.owner_id WHERE full_name = 'Melody Pond';

SELECT A.name AS ANIMALS_NAMES , S.name AS SPECIES_NAMES FROM species S JOIN animals A ON S.id = A.species_id WHERE S.name = 'Pokemon';

SELECT O.full_name AS owner, A.name AS ANIMALS_NAMES FROM Owner O LEFT JOIN animals A ON O.id = A.owner_id;

-- how many animals are there in each species?
SELECT S.name AS SPECIES_NAMES, COUNT(A.name) AS ANIMALS_COUNT FROM species S LEFT JOIN animals A ON S.id = A.species_id GROUP BY S.name;

-- list all Digimon owned by Jeniffer Orwell
SELECT O.full_name AS owner, A.name AS ANIMALS_NAMES FROM Owner O LEFT JOIN animals A ON O.id = A.owner_id WHERE O.full_name = 'Jeniffer Orwell' AND A.name = 'digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT O.full_name AS owner, A.name AS ANIMALS_NAMES FROM Owner O LEFT JOIN animals A ON O.id = A.owner_id WHERE O.full_name = 'Dean Winchester' AND A.escape_attempts = 0;

-- Who owns the most animals?
SELECT O.full_name AS owner, COUNT(A.name) AS ANIMALS_COUNT FROM Owner O LEFT JOIN animals A ON O.id = A.owner_id GROUP BY O.full_name ORDER BY ANIMALS_COUNT DESC;

-- last animal seen by William
SELECT animals.name FROM visits JOIN animals ON animals_id=animals.id WHERE vets_id=1 ORDER BY date_of_visits DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see
SELECT COUNT(DISTINCT animals.name) FROM visits JOIN animals ON animals_id=animals.id WHERE vets_id=3;

-- List all vets and their specialties, including vets with no specialties
SELECT * from vets LEFT OUTER JOIN specializations ON vets_id=id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM animals JOIN visits ON animals.id=visits.animals_id WHERE vets_id=3 AND date_of_visits>'2020-04-01' AND date_of_visits<'2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name FROM animals JOIN visits ON animals.id=visits.animals_id GROUP BY animals.name ORDER BY COUNT(animals.name) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name FROM visits JOIN animals ON animals.id=visits.animals_id WHERE visits.vets_id=2 ORDER BY date_of_visits LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit
SELECT animals.name,vets.name,date_of_visits FROM visits,animals,vets ORDER BY date_of_visits LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species
select vets.name,COUNT(visits.vets_id) as visit,COUNT(species.name) as specialization from vets LEFT JOIN specializations ON vets.id=specializations.vets_id LEFT JOIN species ON species.id=specializations.species_id INNER JOIN visits ON visits.vets_id =vets.id GROUP BY vets.name ORDER BY visit DESC LIMIT 1;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
select vets.name,species.name from vets INNER JOIN specializations ON vets.id!=specializations.vets_id JOIN species ON species.id !=specializations.species_id where vets.name='Maisy Smith' LIMIT 1;

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animals_id = 4;

EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;

EXPLAIN ANALYZE SELECT * FROM owner where email = 'owner_18327@mail.com';
