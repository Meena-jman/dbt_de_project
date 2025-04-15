WITH CUSTOMER_INVOICE_DATA
AS(
    SELECT
        CUST.CUSTOMER_ID,
        INVOICE_ID,
        CUSTOMER_CODE,
        CUSTOMER_SHORT_NAME,
        ACCOUNT_BALANCE,
        INVOICE_NUMBER,
        INVOICE_NET_VALUE,
        INVOICE_TAX_VALUE
    FROM 
        {{ ref('stg_customers_data') }} AS CUST
    LEFT JOIN 
        {{ ref('stg_invoice') }}  AS INVOICE    
    ON
        CUST.CUSTOMER_ID = INVOICE.CUSTOMER_ID

)
SELECT
    *   
FROM
    CUSTOMER_INVOICE_DATA