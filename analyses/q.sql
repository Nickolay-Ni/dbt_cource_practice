with flight_data as (
    select
        departure_airport,
        status
    from {{ ref('fct_flight_schedule') }}
)

select
    departure_airport,
    {{ dbt_utils.pivot(
        'status',
        dbt_utils.get_column_values(ref('fct_flight_schedule'), 'status')
    ) }}
from flight_data
group by 
    departure_airport