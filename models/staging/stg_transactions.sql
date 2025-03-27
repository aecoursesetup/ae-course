{{ config(materialized='view', tags=['staging']) }}

select
    order_id,
    visit_id,
    user_id,
    order_created_at,
    location_id,
    shipping_carrier,
    shipping_method,
    estimated_delivery_date,
    delivered_at
from {{ source('class_source_data','transactions') }}