-- Check total row count (expecting 50: 53 raw rows minus 3 duplicates)
SELECT COUNT(*) AS total_rows FROM jobs;

-- Spot check: confirm company/company_context split worked
SELECT job_id, company, company_context 
FROM jobs 
WHERE company_context IS NOT NULL;

-- Spot check: confirm no unexpected NULLs remain
SELECT * FROM jobs WHERE company IS NULL OR location IS NULL;

-- Check for duplicate job_id values in the final jobs table (expecting 0 rows — 
-- our CTE with ROW_NUMBER() should have filtered these out)
SELECT job_id, COUNT(*) AS occurrences
FROM jobs
GROUP BY job_id
HAVING COUNT(*) > 1;