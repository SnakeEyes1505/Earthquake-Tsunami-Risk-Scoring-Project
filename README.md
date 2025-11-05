# Earthquake–Tsunami Risk Scoring Project

## Project overview

Goal: use a global earthquake dataset to understand **when, where, and under what conditions** earthquakes generate tsunamis, and to build a simple **tsunami risk score**.

Main pieces:

- **Prepare** – clean the raw earthquake table and create a stable core layer in BigQuery.
- **Process** – engineer reusable features such as magnitude/depth classes and risk/severity indices.
- **Analyze** – answer 5 advanced questions about tsunami drivers, geography, time, network quality, and risk ranking.

All work is done in **BigQuery (SQL)** and charts are created in Excel / BI tools from the query outputs.

---

## Project phases

I follow the same 4-step workflow as in my other SQL projects:

1. **Ask** – define the questions.
2. **Prepare** – clean and standardize the raw data.
3. **Process** – build a processed feature view.
4. **Analyze** – run focused queries and visualize the results.

### 1. Ask

Key analytical questions:

- **Q1 – Why / under what conditions?**  
  Under which combinations of magnitude and depth are tsunamis most likely? Can we see clear drivers?

- **Q2 – Where?**  
  Where on the globe do tsunami-related earthquakes cluster? Which areas are hotspots?

- **Q3 – When?**  
  How do earthquakes and tsunamis evolve over time? Are there visible trends by year?

- **Q4 – How reliable is the data?**  
  Does monitoring network quality (number of stations, distance to nearest station) affect what we observe?

- **Q5 – Can we build a score to rank events?**  
  If we combine magnitude, depth, and significance into a tsunami risk score, does it actually surface the most dangerous events?

These questions drive the structure of the SQL views and queries.

---

### 2. Prepare (core layer)

**Goal:** turn the raw CSV into a clean, analysis-ready table in BigQuery.

**SQL:**Main steps (see [`sql/Prepare_Phase.sql`](sql/Prepare_Phase.sql)):

- Load the Kaggle earthquake–tsunami dataset into BigQuery:
  - e.g. `tsunami-risk-assessment.tsunami.earthquake_data_tsunami`
- Filter to realistic ranges from the data card:
  - `magnitude` between **6.5 and 9.1**
  - `depth` between **2.7 and 670.8 km**
  - valid latitude/longitude ranges
- Remove duplicates.
- Build a proper `event_date` from `Year` and `Month`.

Output table:

- `tsunami-risk-assessment.tsunami.v_earthquake_cleaned`

This table is the **core layer** used by all later views.

---

### 3. Process (feature view)

**Goal:** engineer features and risk/severity scores on top of the cleaned data.

**SQL:** `sql/02_processed_view.sql`

Key features created:

- **Magnitude bands**

  ```sql
  CASE
    WHEN magnitude >= 8 THEN 'Severe'
    WHEN magnitude >= 7 THEN 'Strong'
    ELSE 'Moderate'
  END AS magnitude_class
