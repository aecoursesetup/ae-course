{{ config(materialized='view', tags=['staging']) }}

select
    visit_id,
    user_id,
    registered_at as registered_utc,
    datetime(timestamp(registered_at), "America/New_York") as registered_et
from {{ source('class_source_data','registrations') }}