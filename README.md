# 🍕 Pizza Sales Analysis

A SQL-driven analysis of one year of pizza sales data (Jan–Dec 2015), focused on revenue, product performance, order patterns, and category-level performance.

The project combines **MySQL analysis**, an **interactive HTML dashboard**, and a **business-focused analysis report** to turn transactional data into actionable insights.

## 📌 Project Overview

This project analyzes pizza sales transactions to answer key business questions such as:

- How many orders were placed?
- How much revenue was generated?
- Which pizzas and categories perform best?
- Which pizza size is ordered most frequently?
- When are order volumes highest during the day?
- How is revenue distributed across pizza categories?
- How does cumulative revenue grow over time?

The analysis uses a four-table relational schema:

`orders` → `order_details` → `pizzas` → `pizza_types`

The SQL script contains **13 core business questions** plus additional portfolio KPIs.

## 📊 Key Performance Indicators

| KPI | Value |
|---|---:|
| Total Orders | **21,350** |
| Total Revenue | **$817,860.05** |
| Average Order Value | **$38.31** |
| Total Pizzas Sold | **49,574** |
| Average Pizzas / Day | **138.5** |
| Pizza Varieties | **32** |
| Pizza Categories | **4** |
| Pizza Sizes | **5** |

## 🛠️ Tools & Technologies

- **MySQL** — data analysis and querying
- **SQL** — data extraction, aggregation, ranking and analytical calculations
- **HTML / CSS / JavaScript** — interactive dashboard
- **Chart.js** — data visualization
- **PDF** — business analysis report


## 🔍 SQL Concepts Used

- `COUNT()`
- `SUM()`
- `ROUND()`
- Multi-table `JOIN`
- `GROUP BY`
- `ORDER BY`
- `LIMIT`
- Subqueries
- Common Table Expressions (`WITH`)
- `RANK() OVER(PARTITION BY...)`
- `SUM() OVER(...)`
- `HOUR()`
- Revenue and percentage calculations

The SQL script also includes data-validation queries and additional portfolio KPIs.

## 🎯 Business Questions Answered

1. Total number of orders placed
2. Total revenue generated from pizza sales
3. Highest-priced pizza
4. Most common pizza size ordered
5. Top 5 most ordered pizza types by quantity
6. Total quantity ordered by pizza category
7. Distribution of orders by hour of the day
8. Category-wise distribution of pizza varieties
9. Average number of pizzas ordered per day
10. Top 3 pizza types by revenue
11. Revenue contribution by pizza category
12. Cumulative revenue over time
13. Top 3 pizza types by revenue within each category

## 📈 Interactive Dashboard

The project includes a custom interactive dashboard built using HTML, CSS, JavaScript and Chart.js.

Dashboard sections:

- Cumulative Revenue
- Orders by Hour
- Pizza Size Distribution
- Category Volume
- Top 5 Pizzas by Quantity
- Top 3 Pizzas by Revenue within Category
- Key Business Insights



## 💡 Key Insights

### 1. Revenue is broadly distributed

The top five pizzas by quantity are relatively close in sales volume, ranging from **2,371 to 2,453 units**, indicating that sales are not heavily dependent on a single high-volume pizza.

### 2. Classic category leads in volume

The Classic category generated the highest pizza volume with **14,888 units**, followed by Supreme, Veggie and Chicken.

### 3. Large pizzas dominate

Large pizzas were the most ordered size with **18,956 units**, representing approximately **38%** of total pizza volume.

XL and XXL together contributed only **580 units**, or approximately **1.2%** of total pizzas sold.

### 4. Demand has two major daily peaks

Order activity is concentrated around:

- **Lunch:** 12–1 PM
- **Dinner:** 5–6 PM

There is a noticeable mid-afternoon slowdown around 2–3 PM.

### 5. Revenue growth is relatively consistent

Cumulative revenue increases steadily throughout the year, suggesting relatively stable demand without major seasonal spikes in the analyzed dataset.

## 💼 Business Recommendations

- Test pricing or bundle offers for **XL/XXL pizzas** to improve their low sales volume.
- Align staffing and preparation capacity with the **lunch and dinner peaks**.
- Investigate the drivers behind strong-performing pizza categories and apply successful pricing or menu-placement strategies to weaker performers.
- Test targeted promotions during lower-demand periods such as the mid-afternoon window.

## 📁 Project Structure

```text
pizza-sales-analysis/
│
├── README.md
│
├── SQL/
│   └── pizza_sales_analysis.sql
│
├── Dashboard/
│   └── Pizza_Sales_Dashboard.html
│
├── Report/
│   └── Pizza_Sales_Analysis_Report.pdf
│
└── Screenshots/
    └── dashboard.png
```

## 🚀 How to Use

### SQL Analysis

Open:

```text
SQL/pizza_sales_analysis.sql
```

Run the queries in a MySQL 8+ environment containing the required pizza sales tables.

Expected source tables:

```text
orders
order_details
pizzas
pizza_types
```

### Interactive Dashboard

Open:

```text
Dashboard/Pizza_Sales_Dashboard.html
```

in a modern web browser.

The dashboard uses Chart.js and web fonts loaded through external CDNs, so an internet connection may be required for all visual elements to render correctly.

### Business Report

Open the PDF in:

```text
Report/Pizza_Sales_Analysis_Report.pdf
```

for the detailed analysis, findings, recommendations and business-question answers.

## 📚 Dataset Schema

### `orders`

Order-level information.

- `order_id`
- `order_date`
- `order_time`

### `order_details`

Pizza quantities associated with each order.

- `order_details_id`
- `order_id`
- `pizza_id`
- `quantity`

### `pizzas`

Pizza size and pricing information.

- `pizza_id`
- `pizza_type_id`
- `size`
- `price`

### `pizza_types`

Pizza names, categories and ingredient information.

- `pizza_type_id`
- `name`
- `category`
- `ingredients`

## 🧠 What I Learned

- Translating business questions into SQL queries
- Working with relational tables and multi-table joins
- Performing KPI and revenue analysis
- Ranking products using SQL window functions
- Analyzing time-based order patterns
- Building cumulative metrics
- Converting analytical findings into business insights
- Presenting results through an interactive dashboard

## 👤 Author

**Anmol Ratan**

---


# pizza-sales-analysis
SQL-driven analysis of pizza sales data with an interactive dashboard.
