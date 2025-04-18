WITH INVOICE_DATA
AS(
    SELECT
        INVOICEID AS INVOICE_ID,
        CUSTOMERID AS CUSTOMER_ID,
        INVOICENUMBER AS INVOICE_NUMBER,
        SALESORDERNUMBER AS SALES_ORDER_NUMBER,
        CAST(INVOICEDATE AS DATE) AS INVOICE_DATE,
        CAST(INVOICEDATE AS TIME) AS INVOICE_TIME,
        CAST(INVOICEDNETVALUE AS DECIMAL) AS INVOICE_NET_VALUE,
        CAST(INVOICETAXVALUE AS DECIMAL) AS INVOICE_TAX_VALUE,
        CAST(CRETAEDDATE AS DATE) AS CREATED_DATE,
        CAST(CRETAEDDATE AS TIME) AS CREATED_TIME,
        CAST(LASTMODIFIEDDATE AS DATE) AS LAST_MODIFIED_DATE,
        CAST(LASTMODIFIEDDATE AS TIME) AS LAST_MODIFIED_TIME
    FROM
        {{ source('sales', 'INVOICE') }}
)
SELECT 
    *       
FROM 
    INVOICE_DATA