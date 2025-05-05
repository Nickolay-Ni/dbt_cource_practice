
    select
        departure_airport,
    {{ dbt_utils.pivot(
        'status',
        dbt_utils.get_column_values(ref('fct_flight_schedule'), 'status')
    ) }}
    from {{ ref('fct_flight_schedule') }}
    group by 
        departure_airport
