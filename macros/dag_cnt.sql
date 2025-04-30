{% macro dag_cnt(query) %}

{% set models_name = [] %}
{% set seeds_name = [] %}
{% set snapshots_name = [] %}

{% if execute %}
    {% for node in graph.nodes.values() %}
        {% if node.resource_type == 'model' %}
            {% do models_name.append(node.name) %}
        {% elif node.resource_type == 'seed' %}
            {% do seeds_name.append(node.name) %}
        {% elif node.resource_type == 'snapshot' %}
            {% do snapshots_name.append(node.name) %}
        {% endif %}
    {% endfor %}
{% endif %}

{% set models_cnt = models_name | length %}
{% set seeds_cnt = seeds_name | length %}
{% set snapshots_cnt = snapshots_name | length %}

{% do log ('There is in project', True)%}
{% do log('Models' ~ ' ' ~  models_cnt, True) %}
{% do log('Seeds' ~ ' ' ~  seeds_cnt, True) %}
{% do log('Snapshots' ~ ' ' ~  snapshots_cnt, True) %}

{% endmacro %}