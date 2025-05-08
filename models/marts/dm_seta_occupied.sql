{{
  config(
    materialized = 'table',
    )
}}
with Ticket_flights_purchased as (
    select
	flight_id,
	count(ticket_no) as cnt,
	sum(amount) as sum
from
	{{ ref('stg_flights__ticket_flights') }}
group by
	flight_id
),
Ticket_flights_no_sold as (
    select
	aircraft_code,
	count(seat_no) as cnt
from
	{{ ref('stg_flights__seats') }}
group by 
	aircraft_code
),
Boarding_passes_issued as (
    select
	count(ticket_no) as cnt,
	flight_id
from
	{{ ref('stg_flights__boarding_passes') }}
group by 
	flight_id
)
select
    ff.flight_id as Flight_id,
    ff.flight_no as Flight_no,
    ff.scheduled_departure as Scheduled_departure_date,
    ff.departure_airport as Departure_Airport_Code,
    ff.arrival_airport as Arrival_Airport_Code,
    ff.status as Flight_status,
    ff.aircraft_code as Aircraft_code,
    fa.airport_name as Departure_Airport_Name,
    fa2.airport_name as Arrival_Airport_Name,
    fa.city as Departure_Airport_City,
    fa2.city as Arrival_Airport_City,
    fa.coordinates as Departure_Airport_Coordinates,
    fa2.coordinates as Arrival_Airport_Coordinates,
    faa.model as Aircraft_model,
    tp.cnt as Ticket_flights_purchased,
    tp.sum as Ticket_flights_amount,
    tns.cnt - tp.cnt as Ticket_flights_no_sold,
    bpi.cnt as Boarding_passes_issued
from
    {{ ref('fct_flight_schedule') }} as ff
    Left join {{ ref('stg_flights__airports') }} as fa on ff.departure_airport = fa.airport_code
    Left join {{ ref('stg_flights__airports') }} as fa2 on ff.arrival_airport = fa2.airport_code
    Left join {{ ref('stg_flights__aircrafts') }} as faa on ff.aircraft_code = faa.aircraft_code
    Left join Ticket_flights_purchased as tp on ff.flight_id = tp.flight_id
    Left join Ticket_flights_no_sold as tns on ff.aircraft_code = tns.aircraft_code
    Left join Boarding_passes_issued as bpi on ff.flight_id = bpi.flight_id


    