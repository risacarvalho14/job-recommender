--Problem 1: Given a sample portfolii user with skills `SQL, Python, Power BI, Data Visualization`, write a query that scores every job posting in the `jobs` table by how many of those 4 skills appear in its `required_skills` column, without excluding any jobs — then sort so the best matches appear first.
SELECT TOP 10
             job_id, title,required_skills,
(CASE WHEN required_skills LIKE '%SQL%' THEN 1 ELSE 0 END) +
    (CASE WHEN required_skills LIKE '%Python%' THEN 1 ELSE 0 END) +
    (CASE WHEN required_skills LIKE '%Power BI%' THEN 1 ELSE 0 END) +
    (CASE WHEN required_skills LIKE '%Data Visualization%' THEN 1 ELSE 0 END) 
    AS match_score
FROM jobs
ORDER BY match_score DESC;