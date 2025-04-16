SELECT
    *
FROM
    {{ ref('mart_margin') }}
WHERE
    MARGIN_VALUE <0 
AND
    MARGIN_VALUE >100