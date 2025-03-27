{{ config(materialized='view', tags=['staging']) }}

select
*
from {{ source('class_source_data','sessions') }}