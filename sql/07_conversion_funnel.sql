/*
===============================================================================
Conversion Funnel
===============================================================================
*/

SELECT

    COUNTIF(event_name='session_start') AS sessions,

    COUNTIF(event_name='view_item') AS product_views,

    COUNTIF(event_name='add_to_cart') AS add_to_cart,

    COUNTIF(event_name='begin_checkout') AS checkout,

    COUNTIF(event_name='purchase') AS purchases

FROM
`project.dataset.events_*`;