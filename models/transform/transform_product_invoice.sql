WITH PRODUCT_INVOICELINE_DATA
AS(
    SELECT 
        INVOICE_LINE_ID,
        INVOICE_ID,
        SEQUENCE_NUMBER,
        ORDER_LINE_ID,
        INVOICE_QUANTITY,
        LINE_TOTAL_VALUE,
        LINE_TAX_VALUE,
        ITEM_PRICE,
        ITEM_CODE,
        INVOICE_DATE,
        CREATED_DATE,
        LAST_MODIFIED_DATE
    FROM
        {{ ref('stg_invoice_line_data') }}
),
PRODUCT_GROUPING
AS(
    SELECT 
        ITEM_ID,
        ITEM_CODE,
        PRODUCT_GROUP_ID,
        PRODUCT_GROUP,
        PRODUCT_TYPE
    FROM
        {{ ref('stg_product_group') }}
),
PRODUCT_GROUPING_DATA
AS(
    SELECT 
        PROD.ITEM_CODE,
        INVOICE_LINE_ID,
        INVOICE_ID,
        ITEM_ID,
        PRODUCT_GROUP_ID,
        PRODUCT_GROUP,
        PRODUCT_TYPE,
        SEQUENCE_NUMBER,
        ORDER_LINE_ID,
        INVOICE_QUANTITY,
        LINE_TOTAL_VALUE,
        LINE_TAX_VALUE,
        ITEM_PRICE,
        INVOICE_DATE,
        CREATED_DATE,
        LAST_MODIFIED_DATE
    FROM
        PRODUCT_GROUPING AS PROD
    JOIN
        PRODUCT_INVOICELINE_DATA AS INVOICE
    ON
        PROD.ITEM_CODE = INVOICE.ITEM_CODE
)
SELECT
    * 
FROM
    PRODUCT_GROUPING_DATA