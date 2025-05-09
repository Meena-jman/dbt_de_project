WITH CUSTOMER_ORDERS 
AS (
    SELECT
        CUSTOMER_ID,
        DATE_TRUNC('month', ORDER_DATE) AS ACTIVE_MONTH
    FROM 
        {{ ref('stg_sales_orders') }}
    GROUP BY 
        CUSTOMER_ID, 
        DATE_TRUNC('month', ORDER_DATE)
),
LAST_ORDER 
AS(
    SELECT 
        MAX(DATE_TRUNC('month', ORDER_DATE)) AS LAST_ORDER_MONTH
    FROM 
        {{ ref('stg_sales_orders') }}
),
TARGET_MONTH
AS(
    SELECT 
        LAST_ORDER_MONTH,
        LAST_ORDER_MONTH - INTERVAL '1 month' AS TARGET_MONTH_1,
        LAST_ORDER_MONTH - INTERVAL '2 month' AS TARGET_MONTH_2
    FROM
        LAST_ORDER
),
CUSTOMER_ACTIVITY
AS(
    SELECT 
        CO.CUSTOMER_ID,
        COUNT(DISTINCT CO.ACTIVE_MONTH) AS ACTIVE_MONTHS_IN_WINDOW
    FROM
        CUSTOMER_ORDERS CO
    JOIN
        TARGET_MONTH TM
    ON
        CO.ACTIVE_MONTH IN(TM.LAST_ORDER_MONTH, TM.TARGET_MONTH_1, TM.TARGET_MONTH_2)
    GROUP BY
        CO.CUSTOMER_ID
),
REVENUE_TYPE
AS(
    SELECT 
        CUSTOMER_ID,
        CASE
            WHEN ACTIVE_MONTHS_IN_WINDOW <= 3 THEN 'RECURRING'
            ELSE 'NON_RECURRING'
        END AS CUSTOMER_REV_TYPE
    FROM
        CUSTOMER_ACTIVITY
)
SELECT
    C.CUSTOMER_ID,
    C.CUSTOMER_SHORT_NAME,
    CASE
        WHEN COALESCE(RT.CUSTOMER_REV_TYPE, 'NON_RECURRING') = 'RECURRING' 
            THEN 'RECURRING'
        ELSE 'NON_RECURRING'
    END AS CUSTOMER_REV_TYPE
FROM 
    {{ ref('stg_customers_data') }} C
LEFT JOIN
    REVENUE_TYPE RT
ON
    C.CUSTOMER_ID = RT.CUSTOMER_ID
ORDER BY
    CUSTOMER_ID