/* 
Answer: what are the most optimal skills to learn (AKA it is in high demand and high paying skills).
- I dentify skills in high demand and associated with high salaries for data analyst role.
- concentrate on remote positions with high specified salaries.
- why? Target skills that offer job security (high demand) and financial rewards (high salary).
- offering strategic insights for career development in data analysis.
*/  

WITH high_demand AS(
    SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) AS skill_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.job_work_from_home = TRUE
        AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id

),
high_paying AS(
    SELECT 
    ROUND(AVG(salary_year_avg), 0) AS avg_salary,
    skills_dim.skill_id
    FROM job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL 
    AND job_postings_fact.job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id

)

SELECT
    HIGH_DEMAND.skills,
    HIGH_DEMAND.skill_count,
    HIGH_PAYING.avg_salary
FROM high_paying
INNER JOIN high_demand
    ON high_demand.skill_id = high_paying.skill_id
WHERE skill_count > 10
ORDER BY 
    high_paying.avg_salary DESC,
    high_demand.skill_count DESC
LIMIT 25;