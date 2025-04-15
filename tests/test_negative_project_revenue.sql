SELECT 
    *
FROM 
    {{ ref('mart_project_revenue') }}
WHERE 
    GROSS_PROJECT_REVENUE IS NULL