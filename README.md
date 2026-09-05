# job-recommender
Content-based job recommender using SQL, Python, and Power BI
# Job Recommender — Skills-Based Job Matching Dashboard

## Background

This project was built in 2024 as part of a co-op term at a small startup with no existing data infrastructure. With no usable data available, the work involved doing the R&D from scratch — sourcing data, building a dataset, and designing a recommender model to match candidates to job opportunities.

The result: a synthetic job-postings dataset, a SQL-based scoring engine, and an interactive Power BI dashboard that recommends jobs based on a user's selected skills.

## Data Sources

Job postings were sourced from real, publicly listed postings across multiple job boards and company career pages, then compiled into a synthetic dataset for this project. Sources included:

- **VirtualVocations.com** — the largest single source (~19 of 50 postings), covering Data Scientist, Business Intelligence Analyst, Product Analyst, and Marketing Analyst roles
- **Job Bank — Government of Canada (jobbank.gc.ca)** — ~6 postings
- **InsightGlobal.com** — ~6 postings
- **RobertHalf.com** — ~5 postings
- A mix of additional individual sources: CareerBeacon, The Mom Project, GrowthTalent, TopDev, MarketingMonk, WTW Careers, AuditFriendly, Catalitium, ITJobsWatch, HireANiner (UNC Charlotte), and Valor Capital Group

Each job record retains its original `source_url`, so any posting in the dataset can be traced back to where it was sourced.

## Problem Statements

**Problem 1 — Market Exploration**
Given a dataset of job postings compiled from multiple sources, determine which skills are most frequently required across the job market, so we know which skills a recommender should prioritize when scoring candidates.

**Problem 2 — Personalized Recommendation**
Given a user with a specific set of skills, rank all jobs in the dataset by how many of those required skills each job matches, so the user can see which postings best fit their current profile.

## What This Project Demonstrates

- **R&D from scratch**: building a usable dataset and scoring logic where none existed before
- **SQL**: `CASE WHEN` scoring logic, matching queries, ranking and filtering
- **Power BI / DAX**: dynamic measures using `SUMX`, `FILTER`, `VALUES`, and `SELECTEDVALUE` to build a live, slicer-driven recommender — not just static charts
- **Data validation**: cross-checking measure outputs against raw SQL results, and investigating edge cases (e.g. identifying the one job posting that didn't match any tracked skill)

## Tech Stack

- SQL Server (via VS Code + SQLite/SQL extension) — data pipeline: `jobs_raw` → ETL → `jobs` → `vw_jobs_summary`
- Power BI Desktop — dashboard, DAX measures, interactivity
- Synthetic dataset (50 job postings) compiled from real job posting patterns

## Dashboard Overview

**Page 1 — Market Overview**
- KPI cards: job counts by skill (SQL, Python, Power BI, Data Visualization, Excel) + total jobs
- Job Postings by Location
- Most In-Demand Skills (dynamic — responds to skill selection)

**Page 2 — Recommender**
- "Select Your Skills" slicer (multi-select)
- Your Top Job Matches — a live-ranked table scoring every job against the selected skill(s)
- Remote vs. On-site Roles — dynamic donut chart, filtered by selected skills

All visuals are fully interactive: selecting one or more skills in the slicer updates every chart and table on the dashboard simultaneously.

## Key Findings

- **SQL is the most in-demand skill**, appearing in 29 of 50 postings (58%) — nearly double the next closest skill
- **Python and Excel are tied** at 16 postings each, despite being seen as different skill tiers
- **Power BI roles skew heavily remote** — 87.5% of postings requiring Power BI are remote
- Overall, the job market in this dataset splits roughly evenly between remote (52%) and on-site/hybrid (48%) roles
- One posting ("Junior Data Engineer") didn't match any of the 5 tracked skills, reflecting a data engineering role (ETL/Azure/pipelines) outside the BI/analytics skill set this project focuses on

## Who This Helps

- **Job seekers** with data/analytics skills — select your skills, instantly see ranked job matches instead of manually screening postings
- **Career planners** deciding what to learn next — see which skills are most in-demand across real postings before investing time in upskilling
- **Job seekers evaluating location/work-style fit** — see where jobs requiring your specific skills are concentrated, and whether they lean remote or on-site
- **Recruiters (secondary use case)** — benchmark how common a skill requirement is across similar postings, or gauge market competitiveness when writing a new job description

## Scope & Limitations

- This recommender is scoped specifically to data/analytics roles and 5 tracked skills (SQL, Python, Power BI, Data Visualization, Excel). It is not a general-purpose job recommender — a role outside this skill set (e.g., customer service, marketing) would not be meaningfully served by the current dataset or scoring logic.
- The matching logic is rule-based (keyword/skill matching via SQL and DAX), not machine learning. This was a deliberate choice: with a modest, synthetic dataset, a transparent, explainable scoring approach is more defensible than an ML model that would be difficult to validate.
- Job postings do not currently include posting dates, so recency is not factored into recommendations.

## Future Enhancements

- **Recency-weighted scoring**: factor in how recently a job was posted, so fresher listings are favored over stale ones
- **Expanded skill taxonomy and dataset**: extend beyond BI/analytics to other job categories (e.g., customer service, marketing, sales) by broadening the Skills table and sourcing a wider range of postings
- **Lightweight ML layer**: as a stretch goal, a similarity-based matching model (e.g. skill-vector similarity) could complement the rule-based scoring, clearly labeled as an enhancement rather than a replacement
