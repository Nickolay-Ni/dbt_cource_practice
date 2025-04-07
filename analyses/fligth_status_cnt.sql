select
    status,
    count(*)
from
    {{ ref('fct_flight_schedule') }}
group by
    status