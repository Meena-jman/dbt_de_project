{% macro profit_margin_percentage(selling_price_column, avg_buying_price_column, decimal_places=2) %}
  CASE
    WHEN 
        {{ avg_buying_price_column }} IS NULL 
    OR {{ avg_buying_price_column }} = 0 
    THEN
        NULL
    ELSE 
        ROUND((({{ selling_price_column }} - {{ avg_buying_price_column }}) / {{ avg_buying_price_column }}) * 100, {{ decimal_places }})
  END
{% endmacro %}