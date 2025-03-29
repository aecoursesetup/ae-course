{{ config(materialized='table')}}

with sessions as (
select
    visit_id,
    visit_start_et
from {{ ref('stg_sessions') }}
),

reg as (
select
    visit_id,
    user_id
from {{ ref('stg_registrations') }}
),

orders as (
select
    visit_id,
    order_id
from {{ref('stg_transactions') }}
)

select
    sessions.visit_id as visit_id,
    sessions.visit_start_et,
    case when reg.visit_id is not null then 1 else 0 end as has_registration,
    case when orders.visit_id is not null then 1 else 0 end as has_order
from sessions
left join reg
    on sessions.visit_id = reg.visit_id
left join orders
    on sessions.visit_id = orders.visit_id