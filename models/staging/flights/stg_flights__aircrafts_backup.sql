
{{
    config(
        materialized = 'table',
        pre_hook = "
            {% set run_date = run_started_at.strftime('%Y%m%d_%H%M%S') %}
            
            {%- set old_relation = adapter.get_relation(
                database=this.database,
                schema=this.schema,
                identifier=this.identifier) -%}

            {% if old_relation %}
            {%- set backup_relation = api.Relation.create(
                database=this.database,
                schema=this.schema,
                identifier=this.identifier ~ run_date) -%}
            {% do adapter.rename_relation(old_relation, backup_relation) %}
            {% endif %}
        "
    ) 
}}
SELECT
    aircraft_code,
    model,
    "range"
FROM 
    {{ source('demo_src', 'aircrafts') }}
