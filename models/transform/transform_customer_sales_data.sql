WITH CUSTOMER_SALES_DATA
AS(
    SELECT 
        CUST.CUSTOMER_ID,
        ORDER_ID,
        CUSTOMER_CODE,
        CUSTOMER_SHORT_NAME,
        ACCOUNT_BALANCE,
        ORDER_DATE,
        DELIVERY_DATE,
        NET_VALUE,
        TAX_VALUE,
        PROJECT_NUMBER
    FROM 
        {{ ref('stg_customers_data') }} AS CUST
    LEFT JOIN 
        {{ ref('stg_sales_orders') }}  AS ORD
    ON
        CUST.CUSTOMER_ID = ORD.CUSTOMER_ID
    
)
SELECT 
    *
FROM
    CUSTOMER_SALES_DATA