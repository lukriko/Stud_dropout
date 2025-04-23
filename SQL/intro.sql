SELECT * FROM student_data;

-- classification based marital status
SELECT "Marital status",count(*) as total FROM student_data
GROUP BY "Marital status"
ORDER BY "Marital status" ASC;

-- classification based on students natinality
SELECT "Nacionality",count(*) as total_per_country
FROM student_data
GROUP BY "Nacionality"
ORDER BY "Nacionality" ASC;

-- 1 - Portuguese;

-- level of qualification of father,mother
-- father
SELECT "Father's qualification",count(*) as total
FROM student_data
GROUP BY "Father's qualification"
ORDER BY count(*) DESC;
-- 27,14,1,28,3,24

-- gender classifications of data
SELECT "Gender",count(*) as total
FROM student_data
GROUP BY "Gender"
ORDER BY count(*) DESC;
-- 1 - male, 2 - female

-- classification based on the age of enrollment
SELECT "Age at enrollment",count(*) as total
FROM student_data
GROUP BY "Age at enrollment"
ORDER BY count(*) DESC;

-- classification by internationality
SELECT "International",count(*) as total
FROM student_data
GROUP BY "International"
ORDER BY count(*) DESC;
--  0 for no, 1 for yes