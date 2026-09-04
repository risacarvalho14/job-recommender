DROP TABLE IF EXISTS jobs_raw;
GO

CREATE TABLE jobs_raw (
    row_num VARCHAR(50),
    job_id VARCHAR(50),
    title VARCHAR(255),
    company VARCHAR(255),
    location VARCHAR(255),
    description VARCHAR(1000),
    required_skills VARCHAR(500),
    source_url VARCHAR(500)
);
GO

BULK INSERT jobs_raw
FROM 'C:\Users\carva\OneDrive\Desktop\Risa Data Projects\job-recommender\data\messy_jobs_raw.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);
GO

SELECT COUNT(*) AS total_rows FROM jobs_raw;