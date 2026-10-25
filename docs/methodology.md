# Dataset and Methodology

## Data Source

This project analyzes Google Analytics 4 (GA4)-style event data using SQL in Google BigQuery.

## Dataset Details

- **Data platform:** Google BigQuery
- **Data structure:** Event-level data queried using a wildcard table reference (`events_*`)
- **Dataset identifier:** To be confirmed from the actual BigQuery project
- **Analysis scripts:** Eight SQL files covering KPIs, traffic trends, marketing channels, device analysis, landing pages, geographic analysis, conversion funnels, and revenue analysis.

## Key Metrics

The KPI query calculates:
- Total users
- New users
- Total sessions
- Engagement rate
- E-commerce purchases
- Total revenue

## Methodology

SQL aggregation, conditional counting, safe division, and revenue calculations are used to summarize website traffic, engagement, and purchase activity.
