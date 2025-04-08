select
    count(*) as cnt_flights
from 
    {{ ref('fct_flight_schedule') }}
where 
    scheduled_departure::date > '{{ run_started_at.strftime("%Y-%m-%d") }}'