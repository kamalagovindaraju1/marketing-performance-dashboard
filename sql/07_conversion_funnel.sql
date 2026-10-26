-- User-Level Ecommerce Funnel Analysis
-- Source: Public GA4 sample ecommerce dataset
-- Counts distinct users who triggered each event.
-- These counts do not guarantee that users completed stages in order.

WITH funnel_counts AS (
    SELECT
        COUNT(DISTINCT IF(event_name = 'session_start',
            user_pseudo_id, NULL)) AS visited,
        COUNT(DISTINCT IF(event_name = 'view_item',
            user_pseudo_id, NULL)) AS viewed_product,
        COUNT(DISTINCT IF(event_name = 'add_to_cart',
            user_pseudo_id, NULL)) AS added_to_cart,
        COUNT(DISTINCT IF(event_name = 'begin_checkout',
            user_pseudo_id, NULL)) AS began_checkout,
        COUNT(DISTINCT IF(event_name = 'purchase',
            user_pseudo_id, NULL)) AS purchased
    FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
),

funnel_stages AS (
    SELECT 1 AS stage_order, 'Session started' AS stage, visited AS users
    FROM funnel_counts

    UNION ALL
    SELECT 2, 'Product viewed', viewed_product FROM funnel_counts

    UNION ALL
    SELECT 3, 'Added to cart', added_to_cart FROM funnel_counts

    UNION ALL
    SELECT 4, 'Checkout started', began_checkout FROM funnel_counts

    UNION ALL
    SELECT 5, 'Purchase completed', purchased FROM funnel_counts
),

stage_comparison AS (
    SELECT
        stage_order,
        stage,
        users,
        LAG(users) OVER (ORDER BY stage_order) AS previous_stage_users
    FROM funnel_stages
)

SELECT
    stage_order,
    stage,
    users,
    previous_stage_users,
    ROUND(
        SAFE_DIVIDE(previous_stage_users - users,
                    previous_stage_users) * 100,
        2
    ) AS drop_off_rate_pct
FROM stage_comparison
ORDER BY stage_order;
