{{
      config(
        materialized = 'incremental',
        incremental_strategy = 'append'
            ) 
}}
      select
          book_ref,
          book_date,
          total_amount
      from
         {{ source('demo_src', 'bookings') }}
{% if is_incremental() %}
  WHERE 
    book_ref > (select max(book_ref) from {{this}})
{% endif %}
    