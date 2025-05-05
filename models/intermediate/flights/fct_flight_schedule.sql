{{
  config(
    materialized = 'table',
    pre_hook = "
            {% set unique_status = dbt_utils.get_column_values(
              table = ref('stg_flights__flights'),
              column = 'status'
              ) %}

            {% do log('Unique Statuses' ~ ' ' ~ unique_status, info=True) %}
        "
    )
}}
select
    flight_id,
    flight_no,
    scheduled_departure,
    scheduled_arrival,
    departure_airport,
    arrival_airport,
    status,
    aircraft_code,
    actual_departure,
    actual_arrival,
    {{ concat_columns(['flight_id', 'flight_no']) }} as flight_info
from
    {{ ref('stg_flights__flights') }}