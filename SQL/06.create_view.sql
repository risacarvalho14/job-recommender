USE job_recommender;
GO

--Power BI should connect to a stable "reporting layer" rather than directly to the jobs table — so if the table structure ever changes later, your Power BI connection doesn't break. We'll create a view that simply selects everything from jobs.
--Qn1. Write a CREATE VIEW statement called vw_jobs_summary that selects all columns from jobs.

CREATE VIEW vw_jobs_summary AS
SELECT job_id, title, company, company_context, location, description, required_skills, source_url
FROM jobs;

select * from vw_jobs_summary