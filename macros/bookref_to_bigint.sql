{% macro bookref_to_bigint(bookref) %}
    (('0x' || book_ref)::bigint)
{% endmacro %}