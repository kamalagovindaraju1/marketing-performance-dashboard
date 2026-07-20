/*
===============================================================================
Project      : Marketing Performance Dashboard
Author       : Kamala Govindaraju
Database     : Google BigQuery (GA4 Export)

Purpose:
Analyze daily website traffic trends to identify peaks, declines,
and seasonal patterns in user activity.

Business Question:
How many users and sessions are recorded each day?
===============================================================================
*/

SELECT

    PARSE_DATE('%Y%m%d', event_date) AS event_day,

    COUNT(DISTINCT user_pseudo_id) AS total_users,

    COUNTIF(event_name = 'session_start') AS total_sessions,

    COUNTIF(event_name = 'first_visit') AS new_users

FROM
    `project.dataset.events_*`

GROUP BY
    event_day

ORDER BY
    event_day;