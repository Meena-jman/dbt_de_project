{% macro profit_margin_percentage(selling_price_column, avg_buying_price_column) %}
  CASE
    WHEN 
        {{ avg_buying_price_column }} IS NULL 
    OR {{ avg_buying_price_column }} = 0 
    THEN
        NULL
    WHEN 
        {{ selling_price_column }} IS NULL
    OR {{ selling_price_column }} = 0 
    THEN
      0
    ELSE 
        ROUND((({{ selling_price_column }} - {{ avg_buying_price_column }}) / {{ selling_price_column }}) * 100)
  END
{% endmacro %}