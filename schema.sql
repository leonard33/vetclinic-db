/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals ( id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(250),
date_of_birth DATE,
escape_attempts INT,
neutered BOOLEAN,
weight_kg DECIMAL
);

ALTER TABLE animals ADD COLUMN species VARCHAR(250);

CREATE TABLE owner ( id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
full_name VARCHAR(250),
age INT
);

CREATE TABLE species ( id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(250)
);

ALTER TABLE animals ADD COLUMN species_id INT;

ALTER TABLE animals ADD COLUMN owner_id INT;

CREATE TABLE vets ( id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(250),
age INT,
date_of_graduation DATE
);

CREATE TABLE specializations (
    species_id int,
    vets_id int
);

CREATE TABLE visits (
    animals_id int,
    vets_id int,
    date_of_visits date 
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

-- PERFOMANCE INCREASE AS PER TIME ON 'animals' TABLE
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animals_id = 4;

CREATE INDEX animal_id_asc ON visits (animals_id ASC);

SELECT * FROM visits where vets_id = 2;

CREATE INDEX visits_id ON visits(date_of_visits ASC);

EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;

-- PERFOMANCE INCREASE AS PER TIME ON 'owner' TABLE
CREATE INDEX email_property ON owner(email ASC);

EXPLAIN ANALYZE SELECT * FROM owner where email = 'owner_18327@mail.com';
