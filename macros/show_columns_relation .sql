{% macro show_columns_relation (model_name) %}
  {% set relation = ref(model_name) %}
  {% set columns = adapter.get_columns_in_relation(relation) %}

  {% set column_names = [] %}

  {% for column in columns %}
    {% do column_names.append(column.name)%}
  {% endfor%}

  {% for column_name in column_names %}
  {{ column_name }}{{ ',' if not loop.last}}
  {% endfor %}
{% endmacro %}