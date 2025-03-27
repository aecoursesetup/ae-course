{{ config(materialized='view', tags=['staging']) }}

select
    visit_id,
    visit_start_time,
    visit_end_time,
    device_type,
    browser,
    pageview_count,
    sessions.spend_type,
    sessions.attributed_channel,
    sessions.attributed_subchannel,
    channel_group,
    session_metadata
from {{ source('class_source_data','sessions') }} as sessions
left join {{ ref('marketing_mapping') }} as mapping
    on sessions.spend_type = mapping.spend_type
    and sessions.attributed_channel = mapping.attributed_channel
    and sessions.attributed_subchannel = mapping.attributed_subchannel