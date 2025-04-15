{% macro margin_profit_or_loss(value_column) %}
  CASE 
    WHEN {{ value_column }} > 0 THEN 'Profit'
    WHEN {{ value_column }} < 0 THEN 'Loss'
    ELSE 'No Profit or Loss'  
  END
{% endmacro %}