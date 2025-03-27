{{ config(materialized='view', tags=['staging']) }}

select
    visit_id,
    visit_start_time,
    visit_end_time,
    device_type,
    browser,
    pageview_count,
    spend_type,
    attributed_channel,
    attributed_subchannel,
    session_metadata
from {{ source('class_source_data','sessions') }}