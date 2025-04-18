WITH CUSTOMERS_DATA 
AS(
    SELECT
        CAST(CUSTOMERID AS INT) AS CUSTOMER_ID,
        CAST(CUSTOMERCODE AS VARCHAR(50)) AS CUSTOMER_CODE,
        CUSTOMERSHORTNAME AS CUSTOMER_SHORT_NAME,
        CAST(ACCOUNTBALANCE AS INT) AS ACCOUNT_BALANCE,
        CREDITLIMIT AS CREDIT_LIMIT,
        TO_TIMESTAMP(CREATEDDATE, 'DD-MM-YYYY HH24:MI') AS CREATED_DATE,
        TO_TIMESTAMP(LASTMODIFIEDDATE, 'DD-MM-YYYY HH24:MI') AS LAST_MODIFIED_DATE,
    FROM
        {{ source('sales', 'CUSTOMERS') }}
        
)

SELECT 
    *
FROM CUSTOMERS_DATA