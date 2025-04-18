{% set current_date = '{{ run_started_at.strftime("%Y-%m-%d") }}' %}
{% set previus_date_query %}
select distinct
    '{{ run_started_at.strftime("%Y-%m-%d") }}'::date - interval '10 years'as q
from 
    {{ ref('fct_flight_schedule') }}
    {% endset %}
{% set previus_date_result = run_query(previus_date_query) %}
{% if execute %}
    {% set previus_date = previus_date_result.columns[0].values()[0] %}
{% else %}
    {% set previus_date = current_date %}
{% endif %}
select
    count(*) as {{adapter.quote('cnt_flights')}}
from
    {{ ref('fct_flight_schedule') }}
where 
     1 = 1
     and scheduled_departure between '{{previus_date}}' and '{{current_date}}'