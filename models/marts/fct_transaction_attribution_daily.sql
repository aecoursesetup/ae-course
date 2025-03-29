{{ config(materialized='table')}}


select
DATE_TRUNC(order_created_et, DAY)as day,
channel_group,
count(distinct transaction_visit_id) as transactions
from {{ ref('int_transaction_attribution') }}
group by 1,2
