ALTER TABLE elective 
ADD COLUMN achool_id int;

ALTER TABLE elective 
ADD COLUMN elective_id SERIAL;

UPDATE TABLE elective SET school_id = schools_table.school_id 
FROM schools_table 
WHERE elective_school_name = schools_table.school_name; 

ALTER TABLE elective 
DROP COLUMN school_name; 

SELECT school_name, alp_domain, alp_title 
FROM applied_learning_programmes AS alp 
INNER JOIN schools_table AS s
ON alp.school_id = s.school_id 
WHERE alp_domain != 'NULL'
OR alp_title != 'NULL'
ORDER BY alp_domain;

SELECT school_name, alp_domain, alp_title, llp_domain, llp_title 
FROM schools_table AS s
FULL OUTER JOIN applied_learning_programmes AS ap 
ON s.school_id =ap.school_id 
FULL OUTER JOIN learning_for_life_programmes AS l 
ON ap.school_id = l.school_id 
WHERE alp_domain IS NULL 
OR alp_title IS NULL 
OR llp_domain IS NULL 
OR llp_title IS NULL; 

WITH "no_special_programmes" AS (SELECT s.school_id, s.school_name, alp_domain, alp_title, llp_domain, llp_title 
FROM schools_table AS s
FULL OUTER JOIN applied_learning_programmes AS ap
ON s.school_id = ap.school_id
FULL OUTER JOIN learning_for_life_programmes AS l
ON ap.school_id = l.school_id
WHERE alp_domain IS NULL 
OR alp_title IS NULL
OR llp_domain IS NULL 
OR llp_title IS NULL),

"no_special_programmes_mainlevel" AS (SELECT s.school_id, s.school_name, alp_domain, alp_title, llp_domain, llp_title, s.mainlevel_id
FROM no_special_programmes 
LEFT JOIN schools_table s
ON no_special_programmes.school_id = s.school_id
WHERE mainlevel_id = 4)

SELECT mainlevel_id, COUNT (mainlevel_id)
FROM no_special_programmes_mainlevel
GROUP BY mainlevel_id;

/*SELECT school_name, cca_grouping, cca_generic_name
FROM no_special_programmes_mainlevel AS n
INNER JOIN cca 
ON n.school_id = cca.school_id;*/

/*SELECT DISTINCT cca_grouping
FROM no_special_programmes_mainlevel AS n
INNER JOIN cca 
ON n.school_id = cca.school_id;*/

SELECT DISTINCT school_name cca_grouping, cca_generic_name
FROM no_special_programmes_mainlevel AS n
INNER JOIN cca 
ON n.school_id = cca.school_id
WHERE cca_grouping = 'CLUBS AND SOCIETIES'
OR cca_grouping = 'VISUAL AND PERFORMING ARTS'
OR cca_grouping = 'OTHERS';

SELECT DISTINCT cca_grouping, cca_generic_name
FROM no_special_programmes_mainlevel AS n
INNER JOIN cca 
ON n.school_id = cca.school_id
WHERE cca_grouping = 'CLUBS AND SOCIETIES'
OR cca_grouping = 'VISUAL AND PERFORMING ARTS'
OR cca_grouping = 'OTHERS'
ORDER BY cca_generic_name;

WITH "zone" AS (SELECT alp_domain, dgp_code
FROM applied_learning_programmes AS alp 
INNER JOIN schools_table AS s 
ON alp.school_id = s.school_id 
INNER JOIN location AS l 
ON s.location_id = l.location_id 
WHERE alp_domain != 'NULL' 
OR alp_title != 'NULL'
ORDER BY dgp_code)

SELECT COUNT(alp_domain), dgp_code, alp_domain
FROM zone 
GROUP BY rollup (dgp_code, alp_domain) 
ORDER BY dgp_code;



