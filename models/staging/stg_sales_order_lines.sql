WITH SALESORDERLINE_DATA
AS(
    SELECT 
        ORDERID AS ORDER_ID,
        ORDERLINEID AS ORDER_LINE_ID,
        ORDERLINETYPE AS ORDER_LINE_TYPE,
        CAST(ITEMCODE AS VARCHAR(50)) AS ITEM_CODE,
        CAST(QUANTITY AS INT) AS QUANTITY,
        SEQUENCENUMBER AS SEQUENCE_NUMBER,
        CAST(TAXVALUE AS DECIMAL) AS TAX_VALUE,
        CAST(TOTALVALUE AS DECIMAL) AS TOTAL_VALUE,
        CAST(DELIVERYDATE AS DATE) AS DELIVERY_DATE,
        CAST(CRETAEDDATE AS DATE) AS CREATED_DATE,
        CAST(LASTMODIFIEDDATE AS DATE) AS LAST_MODIFIED_DATE
    FROM
        {{ source('sales', 'SALESORDERLINES') }}

)
SELECT
    *
FROM
    SALESORDERLINE_DATA