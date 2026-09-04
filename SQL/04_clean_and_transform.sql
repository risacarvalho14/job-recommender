--Problem 01 : Write a query that shows every unique value in the location column from jobs_raw, along with the character length of each value — so we can spot hidden extra spaces (like "Toronto ON" vs " Toronto ON " which look the same but aren't).
SELECT DISTINCT location, LEN(location) AS char_length
FROM jobs_raw
ORDER BY location;

--Problem 02: Write a query that shows what location would look like after cleaning
SELECT DISTINCT 
    location AS original_location,
    UPPER(TRIM(location)) AS cleaned_location
FROM jobs_raw
ORDER BY cleaned_location;

--Problem 03: write the query that actually updates the location column in jobs_raw in place, applying TRIM() and UPPER() permanently to every row.
UPDATE jobs_raw
SET location = UPPER(TRIM(location))
Select DISTINCT location
from jobs_raw
ORDER BY location;

--Problem 4: Write a query that shows the distinct values in company, along with a COUNT(*) of how many rows have each value — so we can see how many are blank/NULL
SELECT company, COUNT(*) AS row_count
FROM jobs_raw
GROUP BY company
ORDER BY row_count DESC;

--Problem 5: Write a SELECT query against jobs_raw that returns two columns:
--company — the original value, unchanged
--company_clean — a new column showing just the company name without any parenthetical text. For example:
--"Insight Global (Enterprise Client)" → "Insight Global"
--"Robert Half" (no parentheses) → "Robert Half" (unchanged)
SELECT 
    company,
    CASE 
        WHEN CHARINDEX('(', company) > 0 
            THEN TRIM(LEFT(company, CHARINDEX('(', company) - 1))
        ELSE company
    END AS company_clean
FROM jobs_raw;

--Problem 6: Extract the text inside the parentheses into a company_context column.
--"Insight Global (Enterprise Client)" → "Enterprise Client"
--"Robert Half" (no parentheses) → NULL
SELECT 
    company,
    CASE 
        WHEN CHARINDEX('(', company) > 0 
            THEN SUBSTRING(
                    company, 
                    CHARINDEX('(', company) + 1, 
                    CHARINDEX(')', company) - CHARINDEX('(', company) - 1
                 )
        ELSE NULL
    END AS company_context
FROM jobs_raw;

--Problem 7: Write a query that shows the title column with its character length, so we can spot any leading/trailing whitespace issues
SELECT row_num, title, LEN(title) AS title_length
FROM jobs_raw
ORDER BY title;

--Problem 8: Write a SELECT that shows title alongside a cleaned version
SELECT title, TRIM(title) AS clean_title
FROM jobs_raw
ORDER BY clean_title;

--Problem 9: Write a SELECT that shows job_id as-is (the original VARCHAR value), alongside a new column that converts it to an actual integer.
Select job_id,CAST(job_id AS INT) as job_id_int
FROM jobs_raw

--Problem 10: Write a query that shows the original required_skills alongside a cleaned version where every semicolon ; has been replaced with a comma , — so the whole column uses one consistent delimiter.
SELECT 
    required_skills,
    REPLACE(required_skills, ';', ',') AS required_skills_clean
FROM jobs_raw;

--Problem 11: Write a SELECT that shows the original company alongside a version where any NULL is replaced with 'Unknown'
SELECT 
    company,
    ISNULL(company, 'Unknown') AS company_no_null
FROM jobs_raw;

--Problem 12: jobs_raw contains 3 duplicate job_id values (3, 16, 29), each 
-- appearing twice. Since job_id is the PRIMARY KEY in the final `jobs` table, 
-- inserting these duplicates causes a constraint violation and rejects the 
-- entire INSERT. 

TRUNCATE TABLE jobs;

WITH ranked_jobs AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY job_id ORDER BY CAST(row_num AS INT)) AS rn
    FROM jobs_raw
)
INSERT INTO jobs (job_id, title, company, company_context, location, description, required_skills, source_url)
SELECT
    CAST(job_id AS INT),
    TRIM(title),
    CASE 
        WHEN CHARINDEX('(', company) > 0 
            THEN TRIM(LEFT(company, CHARINDEX('(', company) - 1))
        ELSE ISNULL(company, 'Unknown')
    END,
    CASE 
        WHEN CHARINDEX('(', company) > 0 
            THEN SUBSTRING(company, CHARINDEX('(', company) + 1, CHARINDEX(')', company) - CHARINDEX('(', company) - 1)
        ELSE NULL
    END,
    ISNULL(UPPER(TRIM(location)), 'Unknown'),
    description,
    REPLACE(required_skills, ';', ','),
    source_url
FROM ranked_jobs
WHERE rn = 1;

select * from jobs;