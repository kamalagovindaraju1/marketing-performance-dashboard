/*
===============================================================================
Geographic Performance
===============================================================================
*/

SELECT

    geo.country,

    COUNT(DISTINCT user_pseudo_id) AS users,

    COUNTIF(event_name='purchase') AS purchases,

    ROUND(
        SUM(ecommerce.purchase_revenue),
        2
    ) AS revenue

FROM
`project.dataset.events_*`

GROUP BY geo.country

ORDER BY revenue DESC;