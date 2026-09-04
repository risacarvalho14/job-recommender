BULK INSERT jobs_raw
FROM 'C:\Users\carva\OneDrive\Desktop\Risa Data Projects\job-recommender\data\messy_jobs_raw.csv'
WITH (FORMAT='CSV', FIRSTROW=2, FIELDQUOTE='"', FIELDTERMINATOR=',', ROWTERMINATOR='0x0a', CODEPAGE='65001', TABLOCK);

select * from jobs_raw;



-- INSERTING INTO Jobs table
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