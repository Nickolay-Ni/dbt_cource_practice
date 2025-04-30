

{% macro safe_select(table) %}

    {% set path = 'dwh_flights.intermediate' %}
    {% set full_name =  path ~ '.' ~ table %}
    {% set current_models = [] %}

    {% if execute %}
        {% for node in graph.nodes.values() %}
            {% do current_models.append(node.name) %}
        {% endfor %}

        {% do log(current_models, True)%}

    
            {% if table in current_models %}

            select 
                *
            from
                {{ path }}.{{ table }}

            {% else %}

                'SELECT NULL'

            {% endif %}
    {% endif %}
            
{% endmacro %}

{# Теперь работает, не применял нигде, возвращает ошибку компиляции из-за чего проблемы в проекте, работает корректно при сборке в рамках модели #}