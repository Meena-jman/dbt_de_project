WITH SALES_ORDERS_JOIN
AS(
    SELECT 
        SO.ORDER_ID,
        ITEM_CODE,
        SO.ORDER_DATE,
        SO.DELIVERY_DATE,
        NET_VALUE,
        SO.TAX_VALUE,
        PROJECT_NUMBER
    FROM 
        {{ ref('stg_sales_orders') }} AS SO
    JOIN 
        {{ ref('stg_sales_order_lines') }} AS PG
    ON
        SO.ORDER_ID = PG.ORDER_ID
),
SALES_PURCHASE 
AS(
    SELECT 
        ORDER_ID,
        PO.ITEM_CODE,
        SO.ORDER_DATE,
        DELIVERY_DATE,
        NET_VALUE,
        TAX_VALUE,
        PROJECT_NUMBER,
        AVG_BUYING_PRICE
    FROM
        {{ref('transform_margin_sales')}} AS PO
    JOIN
        SALES_ORDERS_JOIN AS SO
    ON
        PO.ITEM_CODE = SO.ITEM_CODE
)
SELECT 
    * 
FROM 
    SALES_PURCHASE
