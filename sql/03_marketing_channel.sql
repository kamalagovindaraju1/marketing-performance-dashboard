/*
===============================================================================
Project      : Marketing Performance Dashboard
Author       : Kamala Govindaraju
Database     : Google BigQuery (GA4 Export)

Purpose:
Evaluate the effectiveness of different marketing channels
in driving website traffic and conversions.

Business Question:
Which acquisition channels generate the highest number of
users, sessions, and purchases?
===============================================================================
*/

SELECT

    traffic_source.source AS marketing_channel,

    COUNT(DISTINCT user_pseudo_id) AS total_users,

    COUNTIF(event_name = 'session_start') AS sessions,

    COUNTIF(event_name = 'purchase') AS purchases,

    ROUND(
        SUM(ecommerce.purchase_revenue),
        2
    ) AS revenue

FROM
    `project.dataset.events_*`

GROUP BY
    marketing_channel

ORDER BY
    revenue DESC;