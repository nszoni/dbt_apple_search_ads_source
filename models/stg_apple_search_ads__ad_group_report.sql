
with base as (

    select * 
    from {{ ref('stg_apple_search_ads__ad_group_report_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_apple_search_ads__ad_group_report_tmp')),
                staging_columns=get_ad_group_report_columns()
            )
        }}
        
    from base
),

final as (
    
    select 
        ad_group_id,
        date, 
        conversions,
        impressions,
        local_spend_amount,
        local_spend_currency,
        new_downloads,
        redownloads,
        taps
    from fields
)

select * from final
