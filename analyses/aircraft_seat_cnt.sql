select
    aircraft_code,
    count(seat_no)
from 
    {{ ref('stg_flights__seats') }}
group by 
    aircraft_code