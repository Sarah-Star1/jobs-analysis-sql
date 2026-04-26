# Introduction
This project focuses on analyzing job data 📊 to understand the relationship between skills and job demand 💼. It explores which skills are most required across different jobs using Python 🐍 and SQL 🗄️, aiming to provide insights for Data Science and Machine Learning roles 🤖.

SQL queries ? check them here [project_sql folder](/project_sql/)
# Background
market more effectively, this project was born
from a desire to pinpoint top-paid and in-demand
skills, streamlining others work to find optimal
jobs.

Data hails from [SQL course] (https://lukebarousse.com/sql). It's packed with insights
on job titles, salaries, locations, and essential
skills.
# Tools I used 
For my deep dive into the data analyst job market,
I harnessed the power of several key tools:

- SQL: The backbone of my analysis, allowing me to
  query the database and unearth critical insights.
- PostgreSQL: The chosen database management
  system, ideal for handling the job posting data.
- Visual Studio Code: My go-to database
  management and executing SQL queries.
- Git & GitHub: Essential for version control and
  sharing my SQL scripts and analysis, ensuring
  collaboration and project tracking.
# The analysis


Each query for this project aimed at investigating
specific aspects of the data analyst job market.
Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered
data analyst positions by average yearly salary
and location, focusing on remote jobs. This query
highlights the high paying opportunities in the
field.

```sql
SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    job_postings_fact.job_location,
    job_postings_fact.job_schedule_type,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_posted_date,
    company_dim.name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.job_location = 'Anywhere'
    AND job_postings_fact.salary_year_avg IS NOT NULL
ORDER BY
    job_postings_fact.salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs
in 2023:

- **Wide Salary Range:** Top 10 paying data
  analyst roles span from $184,000 to $650,000,
  indicating significant salary potential in the
  field.
- **Diverse Employers:** Companies like
  SmartAsset, Meta, and AT&T are among those
  offering high salaries, showing a broad interest
  across different industries.
- **Job Title Variety:** There's a high diversity
  in job titles, from Data Analyst to Director of
  Analytics, reflecting varied roles and
  specializations within data analytics.

![top paying roles](project_sql\assets\visualization.png)
*Bar graph visualizing the salary for the top ten salaries for Data Analysts, ChatGPT generated this graph from my SQL query results*

### 2.skills for top paying job
To understand what skills are required for top paying jobs, I joined the job postings with the skills data, providing insightes to what employes value.
```sql

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT
    skills,
    COUNT(*) AS skill_count
FROM top_paying_jobs tpj
JOIN skills_job_dim sjd
    ON tpj.job_id = sjd.job_id
JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
GROUP BY skills
ORDER BY skill_count DESC;
```
![top paying skills](project_sql\assets\visualization2.png)

### 3.In demand skills for data analysis
![top demanded skills](project_sql\assets\visualization3.png)

### 4. top paying skills
![top paying skills](project_sql\assets\visualization4.png)
### 5. optimal skills
![optimal skills](project_sql\assets\visualization5.png)
# What I learned
Throughout this adventure, I've turbocharged my
SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art
  of advanced SQL, merging tables like a pro and
  wielding WITH clauses for ninja-level temp table
  maneuvers.

- **📊 Data Aggregation:** Got cozy with GROUP BY
  and turned aggregate functions like COUNT() and AVG
  () into my data-summarizing sidekicks.

- **🔎 Analytical Wizardry:** Leveled up my
  real-world puzzle-solving skills, turning
  questionable questions into actionable,
  insightful SQL queries.
# Conclusion
1. **Top-Paying Data Analyst Jobs:** The
   highest-paying jobs for data analysts that allow
   remote work offer a wide range of salaries, the
   highest at $650,000!

2. **Skills for Top-Paying Jobs:** High-paying
   data analyst jobs require advanced proficiency in
   SQL, suggesting it’s a critical skill for earning
   a top salary.

3. **Most In-Demand Skills:** SQL is also the most
   demanded skill in the data analyst job market,
   thus making it essential for job seekers.

4. **Skills with Higher Salaries:** Specialized
   skills, such as SVN and Soliditv, are associated
   with the highest average salaries, indicating a
   premium on niche expertise.

5. **Optimal Skills for Job Market Value:** SQL
   leads in demand and offers for a high average
   salary, positioning it as one of the most optimal
   skills for data analysts to learn to maximize
   their market value.

### closing thoughts
This project enhanced my SQL skills and provided
valuable insights into the data analyst job
market. The findings from the analysis serve as a
guide to prioritizing skill development and job
search efforts. Aspiring data analysts can anchor
position themselves in a competitive job market by
focusing on high-demand, high-salary skills. This
exploration highlights the importance of
continuous learning and adaptation to emerging
trends in the field of data analytics.