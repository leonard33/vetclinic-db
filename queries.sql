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
