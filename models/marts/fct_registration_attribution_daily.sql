{{ config(materialized='table')}}


select
    DATE_TRUNC(registered_et, DAY)as day,
    channel_group,
    count(distinct user_id) as registrations
from {{ ref('int_registration_attribution') }}
group by 1,2