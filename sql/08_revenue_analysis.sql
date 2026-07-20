/*
===============================================================================
Revenue by Marketing Channel
===============================================================================
*/

SELECT

    traffic_source.source AS marketing_channel,

    ROUND(
        SUM(ecommerce.purchase_revenue),
        2
    ) AS revenue,

    COUNTIF(event_name='purchase') AS purchases,

    ROUND(
        SAFE_DIVIDE(
            SUM(ecommerce.purchase_revenue),
            COUNTIF(event_name='purchase')
        ),
        2
    ) AS average_order_value

FROM
`project.dataset.events_*`

GROUP BY marketing_channel

ORDER BY revenue DESC;