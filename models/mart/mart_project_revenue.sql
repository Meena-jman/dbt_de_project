WITH REVENUE_PER_PROJECT
AS(
    SELECT
        PROJECT_NUMBER,
        SUM(NET_VALUE-TAX_VALUE) AS GROSS_PROJECT_REVENUE
    FROM
        {{ ref('stg_sales_orders') }}
    GROUP BY
        PROJECT_NUMBER
)
SELECT
    *,
    {{margin_profit_or_loss('GROSS_PROJECT_REVENUE')}} AS MARGIN_PROFIT_OR_LOSS
FROM
    REVENUE_PER_PROJECT
ORDER BY
    GROSS_PROJECT_REVENUE DESC