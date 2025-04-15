WITH SPEND_PER_PRODUCT_MONTHLY_REVENUE
AS(
    SELECT
        ITEM_CODE,
        SUM(LINE_TOTAL_VALUE) AS LINE_VALUE,
        SUM(LINE_TAX_VALUE) AS LINE_TAX_VALUE,
        DATE_TRUNC('MONTH', INVOICE_DATE) AS MONTHLY
    FROM
        {{ ref('transform_product_invoice') }}
    GROUP BY
        ITEM_CODE,
        DATE_TRUNC('MONTH', INVOICE_DATE)
)
SELECT
    MONTHLY,
    ITEM_CODE,
    (LINE_VALUE-LINE_TAX_VALUE) AS TOTAL_VALUE_PER_PRODUCT_MONTHLY 
FROM
    SPEND_PER_PRODUCT_MONTHLY_REVENUE
ORDER BY
    MONTHLY