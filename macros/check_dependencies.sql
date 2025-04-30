{% macro check_dependencies(model_name) %}
    {%- if execute -%}
        {%- set model_node = graph.nodes[model_name] -%}
        {%- set dependencies = model_node['depends_on']['nodes'] -%}

        {%- set dependency_list = [] -%}
        {%- for dep in dependencies -%}
            {%- do dependency_list.append(dep) -%}
        {%- endfor -%}

        {%- if dependency_list | length > 1 -%}
            {% do log("⚠️ Модель " ~ model_name ~ " зависит от " ~ dependency_list | length|string ~ " объектов!", level='warn') %}
        {%- endif -%}

        {{ return(dependency_list) }}
    {%- else -%}
        {{ return([]) }}  {# Возвращаем пустой список, если не выполняется #}
    {%- endif -%}
{% endmacro %}