{% snapshot dim_flights__aircrafts %}

{{
   config(
       target_schema='snapshot',
       unique_key='aircraft_code',

       strategy='check',
       check_cols = ['model','"range"'],
       dbt_valid_to_current = "'9999-01-01'::date",

       hard_deletes='new_record',

       snapshot_meta_column_names={
            "dbt_valid_from": "dbt_effective_date_from",
            "dbt_valid_to": "dbt_effective_date_to",
            "dbt_is_deleted": "dbt_is_deleted"}
   )
}}
select
    aircraft_code,
    model,
    "range"
from
    {{ ref('stg_flights__aircrafts') }}

{% endsnapshot %}