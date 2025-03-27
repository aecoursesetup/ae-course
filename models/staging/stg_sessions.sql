{{ config(materialized='view', tags=['staging']) }}

select
    visit_id,
    visit_start_time as visit_start_utc,
    datetime(timestamp(visit_start_time), "America/New_York") as visit_start_et,
    visit_end_time as visit_end_utc,
    datetime(timestamp(visit_end_time), "America/New_York") as visit_end_et,
    device_type,
    browser,
    pageview_count,
    sessions.spend_type,
    mapping.channel_group,
    sessions.attributed_channel,
    sessions.attributed_subchannel,
    JSON_VALUE(session_metadata, '$.utm_campaign') as utm_campaign,
    JSON_VALUE(session_metadata, '$.utm_keyword') as utm_keyword,
    session_metadata
from {{ source('class_source_data','sessions') }} as sessions
left join {{ ref('marketing_mapping') }} as mapping
    on sessions.spend_type = mapping.spend_type
    and sessions.attributed_channel = mapping.attributed_channel
    and sessions.attributed_subchannel = mapping.attributed_subchannel