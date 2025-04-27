

{% macro safe_select2(table) %}

    {% set path = 'dwh_flights.intermediate' %}
    {% set full_name =  path ~ '.' ~ table %}

    {% set current_models = [] %}
    {% for node in graph.nodes.values() %}
        {% do current_models.append(node.name) %}
    {% endfor %}

    {% if table in current_models %}

    select 
         *
    from
        {{ path }}.{{ table }}

    {% else %}
        SELECT NULL
    {% endif %}

{% endmacro %}
