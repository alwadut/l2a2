-- Active: 1747684589937@@127.0.0.1@5432@conservation_db


CREATE Table rangers(
ranger_id INT PRIMARY KEY,
name VARCHAR(50),
region VARCHAR(30)
);
INSERT INTO rangers(ranger_id,name,region)
VALUES (1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White','River Delta' ),
(3,'Carol King','Mountain Range');


CREATE TABLE species (
    species_id INT PRIMARY KEY, 
    common_name VARCHAR(50),
    scientific_name VARCHAR(50), 
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

INSERT into species (
    species_id , 
    common_name ,
    scientific_name ,
    discovery_date ,
    conservation_status)
VALUES 
(1 ,'Snow Leopard',' Panthera uncia ','1775-01-01','Endangered '),
(2 ,'Bengal Tiger ',' Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3 ,'Red Panda','Ailurus fulgens','1825-01-01 ','Vulnerable'),
(4 ,'Asiatic Elephant','Elephas maximus indicus ', '1758-01-01','Endangered');

CREATE table sightings(
    sighting_id INT PRIMARY KEY,
    species_id INT,
    ranger_id INT ,
    location VARCHAR(50),
    sighting_time TIMESTAMP,
    notes VARCHAR(100)
  
);  

INSERT into sightings(
    sighting_id,
    species_id,
    ranger_id,
    location,
    sighting_time,
    notes
)
VALUES
(1,1,1,'Peak Ridge ','2024-05-10 07:45:00','Camera trap image captured '),
(2,2,2,'Bankwood Area ','2024-05-12 16:20:00','Juvenile seen'),
(3,3,3,'Bamboo Grove East ','2024-05-15 09:10:00','Feeding observed'),
(4,1,2,'Snowfall Pass ','2024-05-18 18:30:00','null');


DROP TABLE sightings;
-- problem 1 --------------
INSERT INTO rangers(ranger_id,name,region) VALUES (4,'Derek Fox','Coastal Plains');
DELETE FROM rangers
WHERE ranger_id = 6;

select * FROM rangers;
select * FROM species


-- problem -2 =====

SELECT  count  (scientific_name) as unique_species_count
FROM species;




-- p3 ------------

SELECT * from sightings;

DROP Table sightings

SELECT * FROM sightings
     WHERE location ILIKE '%Pass%';




-- p4------------------

SELECT r.name , COUNT(s.sighting_id) as total_sightings
from rangers r
JOIN sightings s ON r.ranger_id = s.ranger_id
GROUP BY  r.name
ORDER BY r.name;


-- p5

select sp.common_name 
 FROM species sp
 left JOIN sightings s On sp.species_id = s.species_id 
  WHERE s.species_id is NULL and sp.common_name is not NULL
GROUP BY sp.common_name;


-- p6---------  Show the most recent 2 sightings.


SELECT r.name , s.sighting_time ,sp.common_name 
FROM rangers r 
join  sightings s ON r.ranger_id = s.sighting_id
JOIN species sp ON s.species_id = sp.species_id
ORDER BY sighting_time DESC;


-- p7-----Update all species discovered before year 1800 to have status 'Historic'.

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

-- p8

SELECT sighting_id,
CASE 
    WHEN extract(HOUR from sighting_time)<12 THEN 'Morning'
    WHEN extract(HOUR from sighting_time) BETWEEN 12 and 16 THEN 'afternoon'

    ELSE  'evining'

END  AS time_of_day
FROM sightings;


-- p9
SELECT * 
from  rangers
WHERE not EXISTS (
    SELECT 1 
    from sightings 
    WHERE sightings.ranger_id = rangers.ranger_id
);



