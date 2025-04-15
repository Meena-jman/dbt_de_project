WITH SALES_orders_data
AS(
    SELECT
        ORDERID AS ORDER_ID,
        ORDERDATE AS ORDER_DATE,
        CUSTOMERID AS CUSTOMER_ID,
        DELIVERYDATE AS DELIVERY_DATE,
        NETVALUE AS NET_VALUE,
        TAXVALUE AS TAX_VALUE,
        PROJECTNUMBER AS PROJECT_NUMBER,
        CAST(CRETAEDDATE AS DATE) AS CREATED_DATE,
        CAST(LASTMODIFIEDDATE AS DATE) AS LAST_MODIFIED_DATE
    FROM
        {{ source('sales','SALESORDERS') }}
)
SELECT 
    *       
FROM
    SALES_orders_data