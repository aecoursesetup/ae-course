{{ config(materialized='view', tags=['staging']) }}

select
    visit_id,
    user_id,
    registered_at
from {{ source('class_source_data','registrations') }}