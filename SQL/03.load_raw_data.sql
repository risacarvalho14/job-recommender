BULK INSERT jobs_raw
FROM 'C:\Users\carva\OneDrive\Desktop\Risa Data Projects\job-recommender\data\messy_jobs_raw.csv'
WITH (FORMAT='CSV', FIRSTROW=2, FIELDQUOTE='"', FIELDTERMINATOR=',', ROWTERMINATOR='0x0a', CODEPAGE='65001', TABLOCK);

select * from jobs_raw;