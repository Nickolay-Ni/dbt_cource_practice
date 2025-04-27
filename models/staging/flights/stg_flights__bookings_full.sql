{{
      config(
        materialized = 'table'
            ) 
}}
select
    {{ bookref_to_bigint('book_ref') }} as book_ref,
    book_date,
    total_amount
from 
    {{ source('demo_src', 'bookings') }}

{{ limit_data_dev('book_date', 3000) }}