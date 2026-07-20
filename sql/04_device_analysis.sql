/*
===============================================================================
Device Category Analysis
===============================================================================
*/

SELECT

    device.category AS device_type,

    COUNT(DISTINCT user_pseudo_id) AS users,

    COUNTIF(event_name='session_start') AS sessions,

    COUNTIF(event_name='purchase') AS purchases,

    ROUND(
        SUM(ecommerce.purchase_revenue),
        2
    ) AS revenue

FROM
`project.dataset.events_*`

GROUP BY device_type

ORDER BY users DESC;