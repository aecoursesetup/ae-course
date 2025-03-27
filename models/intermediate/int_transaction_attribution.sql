{{ config(materialized='table')}}

with transactions as (
select
    visit_id,
    order_created_et
from {{ ref('stg_transactions') }}
),

visits as (
select
    visit_id,
    channel_group
from {{ ref('stg_sessions')}}
)

select
order_created_et,
channel_group,
transactions.visit_id
from visits
join transactions
    on visits.visit_id = transactions.visit_id