{%- macro concat_columns(columns, delim = ', ') %}
    {%- for column in columns -%}
        {{ column }} {% if not loop.last %} || '{{ delim }}' || {% endif %}
    {%- endfor -%}
{% endmacro %}





{% macro drop_old_relations(dryrun = False) %}

{# находим все модели,seed и snapshot проекта dbt #}

{% set current_models = [] %}

    {% for node in graph.nodes.values() | selectattr("resource_type", "in", ["model", "snapshot", "seed"])%}
        {% do current_models.append(node.name) %}
    {% endfor %}

{% do log(current_models, True) %}

{# формирование скрипта удаления всех таблиц и представлений, которым не соответсвует ни одна модель, seed или snapshot #}

{% set cleanup_query %}
With models_to_drop AS (
    SELECT
        CASE 
            WHEN table_type = 'BASE TABLE' THEN 'TABLE'
            WHEN table_type = 'VIEW' THEN 'VIEW'
        END as RELATION_TYPE,
        CONCAT_WS('.', TABLE_CATALOG,TABLE_SCHEMA, TABLE_NAME) as RELATION_NAME
    FROM
        {{ target.database }}.INFORMATION_SCHEMA.TABLES
    WHERE
        TABLE_SCHEMA = '{{ target.schema }}'
        AND UPPER(TABLE_NAME) NOT IN (
            {%- for model in current_models -%}
                '{{ model.upper() }}'
                {%- if not loop.last -%}
                    ,
                {%- endif %}
            {%- endfor -%}
        )
)
SELECT
    'DROP' || ' ' || RELATION_TYPE || ' ' || RELATION_NAME || ';' as DROP_COMMANDS
FROM
    models_to_drop;
{% endset %}

{% do log(cleanup_query,True)%}

{% set drop_commands = run_query(cleanup_query).columns[0].values() %}

{# удаление лишних таблиц и представлений и вывод скрипта удаления в лог #}

  {% if drop_commands %}
            {% if dryrun | as_bool == False %}
                {% do log('Executing DROP commands ...', True) %}
            {% else %}
                {% do log('Printing DROP commands ...', True) %}
            {% endif %}
        
            {% for drop_command in drop_commands %}
                {% do log(drop_command, True) %}
                {% if  dryrun | as_bool == False %}
                    {% do run_query(drop_command) %}
                {% endif %}
            {% endfor %}
        {% else %}
             {% do log('No relations to clean', True) %}
        {% endif %}

{% endmacro %}



