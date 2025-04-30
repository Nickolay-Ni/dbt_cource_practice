{% macro check_dependencies2() %}

{% set q = model.depends_on.nodes | length %}
    {% if q > 1 %}
    {% do log(" Model " ~ model.name ~ " depends_on " ~ q ~ " objects!", info = true) %}
    {% endif %}

{% endmacro %}