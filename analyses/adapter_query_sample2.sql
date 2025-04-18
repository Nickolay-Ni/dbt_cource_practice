{% set relation = api.Relation.create(
      database="dwh_flights",
      schema="intermediate",
      identifier="fct_flight_schedule",
      type="table"
    ) 
%}

{% for column in adapter.get_columns_in_relation(relation) -%}
  {{ "Column: " ~ column }}
{% endfor %}



-- пример использования adapter.get_missing_columns

{%- set fct_fligths_schedule = api.Relation.create(
      database="dwh_flights",
      schema="intermediate",
      identifier="fct_fligths_schedule",
      type="table"
    ) 
-%}

{% set stg_flights__flights = api.Relation.create(
      database="dwh_flights",
      schema="intermediate",
      identifier="stg_flights__flights",
      type="table"
    ) 
%}

{% for column in adapter.get_missing_columns(stg_flights__flights, fct_fligths_schedule) -%}
  {{ "Column: " ~ column }}
{% endfor %} 


-- пример использования adapter.expand_target_column_types

{%- set fct_flight_schedule = api.Relation.create(
        database = 'dwh_flights',
        schema = 'intermediate',
        identifier = 'fct_flight_schedule',
        type = 'table'
    ) 
-%}

{% set stg_flights__flights = api.Relation.create(
        database = 'dwh_flights',
        schema = 'intermediate',
        identifier = 'stg_flights__flights',
        type = 'table'
    ) 
%}

{% do adapter.expand_target_column_types(stg_flights__flights, fct_flight_schedule) %}

{% for column in adapter.get_columns_in_relation(stg_flights__flights) %}
    {{ 'Column: ' ~ column }}
{%- endfor %} 

{% for column in adapter.get_columns_in_relation(fct_flight_schedule) %}
    {{ 'Column: ' ~ column }}
{%- endfor %} 