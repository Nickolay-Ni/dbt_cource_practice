{{
    config(
        materialized = 'table',
    )
}}
select
    {{ dbt_utils.generate_surrogate_key(['book_ref']) }} as surrogate_key,
    book_ref,
    book_date,
    total_amount
from
    {{ ref('stg_flights__bookings') }}