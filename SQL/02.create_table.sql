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

DROP TABLE IF EXISTS jobs;
GO

CREATE TABLE jobs (
    job_id INT PRIMARY KEY,
    title VARCHAR(255),
    company VARCHAR(255),
    company_context VARCHAR(255),
    location VARCHAR(255),
    description VARCHAR(1000),
    required_skills VARCHAR(500),
    source_url VARCHAR(500)
);
GO

