{{
  config(
    materialized = 'table'
    )
}}
Select
    city,
    region
from 
    {{ ref('city_region') }}