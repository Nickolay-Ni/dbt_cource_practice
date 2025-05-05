{% set unique_status = dbt_utils.get_column_values(
    table = ref('fct_flight_schedule'),
    column = 'status'
) %}

select
    *
from
    {{ ref('fct_flight_schedule') }}
where
    status in ( '{{unique_status}}' )