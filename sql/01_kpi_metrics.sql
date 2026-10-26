-- Marketing Performance KPI Summary
-- Source: Public GA4 sample ecommerce dataset
-- Note: These results are separate from the Looker Studio dashboard.

WITH session_flags AS (
    SELECT
        user_pseudo_id,
        (SELECT value.int_value
         FROM UNNEST(event_params)
         WHERE key = 'ga_session_id') AS session_id,
        MAX(
            (SELECT value.string_value
             FROM UNNEST(event_params)
             WHERE key = 'session_engaged')
        ) AS engaged
    FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
    GROUP BY user_pseudo_id, session_id
),

session_metrics AS (
    SELECT
        ROUND(
            SAFE_DIVIDE(
                COUNTIF(engaged = '1'),
                COUNT(*)
            ) * 100,
            2
        ) AS engagement_rate
    FROM session_flags
    WHERE session_id IS NOT NULL
),

kpis AS (
    SELECT
        COUNT(DISTINCT user_pseudo_id) AS total_users,
        COUNTIF(event_name = 'first_visit') AS new_users,
        COUNTIF(event_name = 'session_start') AS total_sessions,
        COUNTIF(event_name = 'purchase') AS ecommerce_purchases,
        ROUND(SUM(ecommerce.purchase_revenue), 2) AS total_revenue
    FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
)

SELECT
    k.total_users,
    k.new_users,
    k.total_sessions,
    s.engagement_rate,
    k.ecommerce_purchases,
    k.total_revenue
FROM kpis AS k
CROSS JOIN session_metrics AS s;
