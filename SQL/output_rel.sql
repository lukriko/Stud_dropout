-- - Unemployment rate: variable indicating the unemployment rate(Unemployment rate (%)).
-- - Inflation rate: Numeric variable indicating the inflation rate(Inflation rate (%)).
-- - GDP: Numeric variable indicating the Gross Domestic Product.
-- - output: Categorical variable indicating the target variable (e.g., Dropout, Graduate, Enrolled).

SELECT "Unemployment rate",count("Unemployment rate")
FROM student_data
GROUP BY "Unemployment rate"; 

SELECT * from student_data;

-- How do grades differ between students who drop out and those who graduate?
-- Curricular units 1st sem (grade)
-- Curricular units 2nd sem (grade)

 SELECT "Output",avg("Curricular units 1st sem (grade)") as "1st_term_mean",
        avg("Curricular units 2nd sem (grade)") as "2nd_term_mean",
        stddev_samp("Curricular units 1st sem (grade)") as "1st_term_stdev",
        stddev_samp("Curricular units 2nd sem (grade)") as "2nd_term_stdev",
        var_samp("Curricular units 1st sem (grade)") as "1st_term_var",
        var_samp("Curricular units 2nd sem (grade)") as "2nd_term_var"
        FROM student_data
        GROUP BY "Output";

-- mean -- dropout < enrolled < Graduate
--  standard deviation -- graduate < enrolled < dropout
-- higher devation means more dispersion of the data from the mean 
-- which in this particular case might represent simple as well as dropout because of family matters
--  variance -- graduate < enrolled < dropout


-- What’s the relationship between parental qualifications and student success?
-- father

SELECT  "Output","Father's qualification",count("Output")
        FROM student_data
        WHERE "Output" LIKE 'Graduate'
        GROUP BY "Father's qualification","Output"
        ORDER BY count("Output") DESC
        LIMIT 5;
        -- for graduates
        -- top five 27,14,1,28,3
        -- bottom five 32,18,21,30,33


SELECT  "Output","Father's qualification",COUNT("Output")
        FROM student_data
        WHERE "Output" LIKE 'Dropout'
        GROUP BY "Father's qualification","Output"
        ORDER BY COUNT("Output") ASC
        LIMIT 5;
        -- for dropouts
        -- top five 27,1,14,28,3
        -- bottom five 19,23,13,22,31

-- well many students graduate and dont based on the top qualification for both graduates and dropouts
-- which is 2nd cycle of the general high school course


-- Do scholarship holders have a higher graduation rate?
-- scholarship rate
SELECT 
    "Output",
    COUNT(*) AS output_count,
    ROUND((COUNT(*) * 100.0 / total.total_count), 2) || '%' AS output_percentage
FROM student_data,
    (
        SELECT COUNT(*) AS total_count 
        FROM student_data 
        WHERE "Scholarship holder" = 0
    ) AS total
WHERE "Scholarship holder" = 0
GROUP BY "Output", total.total_count;


-- output rate
SELECT
     "Output",
     COUNT(*) AS output_count,
     ROUND((COUNT(*) * 1.0 / total.total_count)*100, 3) || '%' AS output_ratio
FROM student_data,
        (
            SELECT COUNT(*) AS total_count FROM student_data
        ) AS total
GROUP BY "Output", total.total_count;

-- difference percentage
-- output rate
-- scholarship rate
WITH scholarship_cte AS (
    SELECT 
        "Output", 
        COUNT(*) AS count_scholarship
    FROM student_data
    WHERE "Scholarship holder" = 1
    GROUP BY "Output"
),
total_cte AS (
    SELECT 
        "Output", 
        COUNT(*) AS count_total
    FROM student_data
    GROUP BY "Output"
),
scholarship_total AS (
    SELECT COUNT(*) AS total_scholarship FROM student_data WHERE "Scholarship holder" = 1
),
overall_total AS (
    SELECT COUNT(*) AS total_students FROM student_data
)

SELECT 
    t."Output",
    ROUND((s.count_scholarship * 100.0 / st.total_scholarship), 2) AS scholarship_percentage,
    ROUND((t.count_total * 100.0 / ot.total_students), 2) AS total_percentage,
    ROUND((s.count_scholarship * 100.0 / st.total_scholarship) - (t.count_total * 100.0 / ot.total_students), 2) AS percentage_point_difference
FROM total_cte t
LEFT JOIN scholarship_cte s ON t."Output" = s."Output"
CROSS JOIN scholarship_total st
CROSS JOIN overall_total ot;




-- Are dropout rates higher during years of high unemployment or inflation?
SELECT "Output","Unemployment rate",COUNT("Output")
FROM student_data
WHERE "Output" = 'Dropout'
GROUP BY "Unemployment rate","Output"
ORDER BY COUNT("Output") DESC;

SELECT "Output","Unemployment rate",COUNT("Output")
FROM student_data
WHERE "Output" = 'Enrolled'
GROUP BY "Unemployment rate","Output"
ORDER BY COUNT("Output") DESC;

SELECT "Output","Unemployment rate",COUNT("Output")
FROM student_data
WHERE "Output" = 'Graduate'
GROUP BY "Unemployment rate","Output"
ORDER BY COUNT("Output") DESC;

-- not clear more exploration is needed


-- How does marital status at enrollment affect dropout or success rates?
SELECT "Marital status",COUNT(*) as total_per_status_Dropout
FROM student_data
WHERE "Output" = 'Dropout'
GROUP BY "Marital status"
ORDER BY "Marital status" ASC;

SELECT "Marital status",COUNT(*) as total_per_status_Graduate
FROM student_data
WHERE "Output" = 'Graduate'
GROUP BY "Marital status"
ORDER BY "Marital status" ASC;


-- side by side
WITH cte_1 AS (
    SELECT "Marital status" as marital_status,COUNT(*) as total_per_status_Dropout
    FROM student_data
    WHERE "Output" = 'Dropout'
    GROUP BY "Marital status"
    ORDER BY "Marital status" ASC
), cte_2 AS (
    SELECT "Marital status" as marital_status,COUNT(*) as total_per_status_Graduate
    FROM student_data
    WHERE "Output" = 'Graduate'
    GROUP BY "Marital status"
    ORDER BY "Marital status" ASC
)
    SELECT cte_1.marital_status,
    cte_1.total_per_status_Dropout,
    cte_2.total_per_status_Graduate
    FROM cte_1
    JOIN cte_2 
        ON cte_1.marital_status = cte_2.marital_status;

        -- percentage 

WITH cte_1 AS (
    SELECT "Marital status" as marital_status,COUNT(*) as total_per_status_Dropout
    FROM student_data
    WHERE "Output" = 'Dropout'
    GROUP BY "Marital status"
    ORDER BY "Marital status" ASC
), cte_2 AS (
    SELECT "Marital status" as marital_status,COUNT(*) as total_per_status_Graduate
    FROM student_data
    WHERE "Output" = 'Graduate'
    GROUP BY "Marital status"
    ORDER BY "Marital status" ASC
)
    SELECT cte_1.marital_status,
    cte_1.total_per_status_Dropout,
    cte_2.total_per_status_Graduate
    FROM cte_1
    JOIN cte_2 
        ON cte_1.marital_status = cte_2.marital_status;


        -- correlation

SELECT corr("GDP","Curricular units 2nd sem (grade)") FROM student_data

-- How do international students with low parental education perform compared to locals with high parental education?
-- Group A: International students with low parental education
SELECT 
    "Output",
    ROUND(AVG("Curricular units 1st sem (grade)")::numeric, 2) AS avg_grade_1st_sem,
    ROUND(AVG("Curricular units 2nd sem (grade)")::numeric, 2) AS avg_grade_2nd_sem,
    COUNT(*) AS student_count
FROM student_data
WHERE "International" = 1
    AND "Mother's qualification" IN (1, 9, 10, 11, 12, 14, 18, 19, 22, 26, 27, 29, 30, 34, 35, 36, 37, 38)
    AND "Father's qualification" IN (1, 9, 10, 11, 12, 13, 14, 18, 19, 20, 22, 25, 26, 27, 29, 30, 31, 33, 34, 35, 36, 37, 38)
GROUP BY "Output";


-- Group B: Local students with high parental education
SELECT 
    "Output",
    ROUND(AVG("Curricular units 1st sem (grade)")::numeric, 2) AS avg_grade_1st_sem,
    ROUND(AVG("Curricular units 2nd sem (grade)")::numeric, 2) AS avg_grade_2nd_sem,
    COUNT(*) AS student_count
FROM student_data
WHERE "International" = 0
    AND "Mother's qualification" IN (2, 3, 4, 5, 6, 39, 40, 41, 42, 43, 44)
    AND "Father's qualification" IN (2, 3, 4, 5, 6, 39, 40, 41, 42, 43, 44)
GROUP BY "Output";



SELECT "GDP", "Output", COUNT(*) 
FROM student_data
WHERE "Output" = 'Dropout'
GROUP BY "GDP", "Output"
ORDER BY "GDP" DESC;
