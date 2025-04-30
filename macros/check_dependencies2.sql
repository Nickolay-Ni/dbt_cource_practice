{% macro check_dependencies2() %}
    {%- set dependencies = get_ref('this').dependencies %}
    {%- set dependency_count = dependencies | length %}

    {%- if dependency_count > 1 %}
        {%- do log("⚠️ Модель " ~ this.name ~ " зависит от " ~ dependency_count|string ~ " объектов!", info=True) %}
    {%- endif %}
{% endmacro %}