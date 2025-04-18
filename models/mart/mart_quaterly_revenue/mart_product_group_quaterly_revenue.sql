WITH PRODUCT_GROUP_QUARTERLY_REVENUE
AS(
    SELECT
        PRODUCT_GROUP,
        SUM(LINE_TOTAL_VALUE) AS LINE_VALUE,
        SUM(LINE_TAX_VALUE) AS LINE_TAX_VALUE,
        DATE_TRUNC('QUARTER', INVOICE_DATE) AS QUARTERLY
    FROM
        {{ ref('transform_product_invoice') }}
    GROUP BY
        PRODUCT_GROUP,
        DATE_TRUNC('QUARTER', INVOICE_DATE)
)
SELECT
    PRODUCT_GROUP,
    QUARTERLY,
    (LINE_VALUE-LINE_TAX_VALUE) AS TOTAL_VALUE_PRODUCT_GROUP_QUARTERLY
FROM
    PRODUCT_GROUP_QUARTERLY_REVENUE
ORDER BY
    QUARTERLY,
    PRODUCT_GROUP
