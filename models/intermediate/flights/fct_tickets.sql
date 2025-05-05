{{
  config(
    materialized = 'table',
    )
}}
select
    {{- show_columns_relation ('stg_flights__tickets') -}}
from
    {{ ref('stg_flights__tickets') }}
where 
    passenger_id not in (select passenger_id from {{ ref('passenger_id') }})