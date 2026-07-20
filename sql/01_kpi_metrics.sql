/*
===============================================================================
Project      : Marketing Performance Dashboard
Author       : Kamala Govindaraju
Database     : Google BigQuery (GA4 Export)
Purpose      : Calculate executive marketing KPIs for dashboard reporting.
===============================================================================

Business Objective:
Provide a summary of key website performance metrics including users,
sessions, engagement, conversions, and revenue.

===============================================================================
*/

SELECT
    COUNT(DISTINCT user_pseudo_id) AS total_users,

    COUNTIF(event_name = 'first_visit') AS new_users,

    COUNTIF(event_name = 'session_start') AS total_sessions,

    ROUND(
        SAFE_DIVIDE(
            COUNTIF(event_name = 'user_engagement'),
            COUNTIF(event_name = 'session_start')
        ) * 100,
        2
    ) AS engagement_rate,

    COUNTIF(event_name = 'purchase') AS ecommerce_purchases,

    ROUND(
        SUM(
            ecommerce.purchase_revenue
        ),
        2
    ) AS total_revenue

FROM
`project.dataset.events_*`;