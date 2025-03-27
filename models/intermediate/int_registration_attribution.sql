{{ config(materialized='table')}}

with registrations as (
select
    visit_id,
    registered_et,
    registered_utc,
    user_id
from {{ ref('stg_registrations') }}
),

sessions as (
select
    visit_id,
    channel_group,
    attributed_channel,
    attributed_subchannel,
    utm_campaign,
    utm_keyword
from {{ ref('stg_sessions') }}
)

select
    a.registered_et,
    b.channel_group,
    user_id
from registrations as a
left join sessions as b
    on a.visit_id = b.visit_id
