{{ config(materialized='incremental', unique_key='visit_id') }}

select
*
from {{ ref('stg_sessions') }}

where visit_id NOT IN (select visit_id from {{ this }} )