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
