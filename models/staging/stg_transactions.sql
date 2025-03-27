{{ config(materialized='view', tags=['staging']) }}

select
    order_id,
    visit_id,
    user_id,
    order_created_at as order_created_utc,
    datetime(timestamp(order_created_at), "America/New_York") as order_created_et,
    location_id,
    shipping_carrier,
    shipping_method,
    estimated_delivery_date as estimated_deilvery_utc,
    datetime(timestamp(estimated_delivery_date), "America/New_York") as estimated_delivery_et,
    delivered_at as delivered_at_utc,
    datetime(timestamp(delivered_at), "America/New_York") as delivered_at_et
from {{ source('class_source_data','transactions') }}