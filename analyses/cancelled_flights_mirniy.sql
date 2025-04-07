select
    scheduled_departure::date as dates,
    count(*) as Cancelled_flights
from
    {{ ref('fct_flight_schedule') }}
where
    1 = 1 
    and departure_airport = 'MJZ'
    and status = 'Cancelled'
group by
    dates
    
