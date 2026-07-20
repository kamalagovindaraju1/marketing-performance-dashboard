/*
===============================================================================
Top Landing Pages
===============================================================================
*/

SELECT

    page_location,

    COUNT(*) AS page_views,

    COUNT(DISTINCT user_pseudo_id) AS users

FROM

(
SELECT

    user_pseudo_id,

    (SELECT value.string_value
     FROM UNNEST(event_params)
     WHERE key='page_location') AS page_location

FROM
`project.dataset.events_*`

WHERE event_name='page_view'

)

GROUP BY page_location

ORDER BY page_views DESC

LIMIT 10;