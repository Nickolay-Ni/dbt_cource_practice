{%- set source_relation = adapter.get_relation(
      database="dwh_flight",
      schema="intermediate",
      identifier="fct_flight_schedule") -%}

{{ source_relation.database }}
{{ source_relation.schema }}
{{ source_relation.identifier }}
{{ source_relation.is_table }}
{{ source_relation.is_view }}
{{ source_relation.is_cte }}



{%- set source_relation = load_relation( ref('fct_bookings')) %}

{{ source_relation.database }}
{{ source_relation.schema }}
{{ source_relation.identifier }}
{{ source_relation.is_table }}
{{ source_relation.is_view }}
{{ source_relation.is_cte }}



{%- set source_relation = load_relation( ref('fct_bookings')) %}
{% set columns = adapter.get_columns_in_relation(source_relation) %}
{% for column in columns %}
    {{ 'columns: ' ~ column }}
{% endfor %}



{% do adapter.create_schema(   
api.Relation.create(
        database = "dwh_flights",
        schema = "test_schema")
) %}



{% do adapter.drop_schema(   
api.Relation.create(
        database = "dwh_flights",
        schema = "test_schema")
) %}
