-- ============================================================
-- PIZZA SALES ANALYSIS 

-- ============================================================
-- Tables: orders, order_details, pizzas, pizza_types
-- ============================================================

-- schema:
-- orders(order_id, order_date, order_time)
-- order_details(order_details_id, order_id, pizza_id, quantity)
-- pizzas(pizza_id, pizza_type_id, size, price)
-- pizza_types(pizza_type_id, name, category, ingredients)

-- ============================================================
-- 0. DATA VALIDATION
-- ============================================================

SELECT COUNT(*) AS total_orders FROM orders;
SELECT COUNT(*) AS total_order_line_items FROM order_details;
SELECT COUNT(*) AS total_pizza_types FROM pizza_types;
SELECT COUNT(DISTINCT category) AS total_categories FROM pizza_types;
SELECT COUNT(DISTINCT size) AS total_sizes FROM pizzas;


-- ============================================================
-- 1. TOTAL NUMBER OF ORDERS
-- ============================================================

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders;


-- ============================================================
-- 2. TOTAL REVENUE GENERATED FROM PIZZA SALES
-- ============================================================

SELECT ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details AS od
JOIN pizzas AS p
    ON od.pizza_id = p.pizza_id;


-- ============================================================
-- 3. HIGHEST-PRICED PIZZA
-- ============================================================

SELECT
    pt.name AS pizza_name,
    p.size,
    p.price
FROM pizzas AS p
JOIN pizza_types AS pt
    ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;


-- ============================================================
-- 4. MOST COMMON PIZZA SIZE ORDERED
-- ============================================================

SELECT
    p.size,
    SUM(od.quantity) AS total_quantity
FROM order_details AS od
JOIN pizzas AS p
    ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC
LIMIT 1;


-- ============================================================
-- 5. TOP 5 MOST ORDERED PIZZA TYPES BY QUANTITY
-- ============================================================

SELECT
    pt.name AS pizza_name,
    SUM(od.quantity) AS total_quantity
FROM order_details AS od
JOIN pizzas AS p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types AS pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;


-- ============================================================
-- 6. TOTAL QUANTITY ORDERED PER PIZZA CATEGORY
-- ============================================================

SELECT
    pt.category,
    SUM(od.quantity) AS total_quantity
FROM order_details AS od
JOIN pizzas AS p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types AS pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity DESC;


-- ============================================================
-- 7. DISTRIBUTION OF ORDERS BY HOUR OF DAY
-- COUNT DISTINCT ORDER_ID IS USED BECAUSE ONE ORDER CAN
-- CONTAIN MULTIPLE LINE ITEMS.
-- ============================================================

SELECT
    HOUR(o.order_time) AS order_hour,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders AS o
GROUP BY HOUR(o.order_time)
ORDER BY order_hour;


-- ============================================================
-- 8. CATEGORY-WISE DISTRIBUTION OF PIZZA VARIETIES
-- ============================================================

SELECT
    category,
    COUNT(DISTINCT pizza_type_id) AS pizza_varieties
FROM pizza_types
GROUP BY category
ORDER BY pizza_varieties DESC;


-- ============================================================
-- 9. AVERAGE NUMBER OF PIZZAS ORDERED PER DAY
-- ============================================================

SELECT
    ROUND(
        SUM(od.quantity) / COUNT(DISTINCT o.order_date),
        2
    ) AS avg_pizzas_per_day
FROM orders AS o
JOIN order_details AS od
    ON o.order_id = od.order_id;


-- ============================================================
-- 10. TOP 3 PIZZA TYPES BY REVENUE
-- ============================================================

SELECT
    pt.name AS pizza_name,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details AS od
JOIN pizzas AS p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types AS pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 3;


-- ============================================================
-- 11. REVENUE CONTRIBUTION % BY PIZZA CATEGORY
-- ============================================================

SELECT
    pt.category,
    ROUND(
        SUM(od.quantity * p.price) /
        (
            SELECT SUM(od2.quantity * p2.price)
            FROM order_details AS od2
            JOIN pizzas AS p2
                ON od2.pizza_id = p2.pizza_id
        ) * 100,
        2
    ) AS revenue_contribution_pct
FROM order_details AS od
JOIN pizzas AS p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types AS pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY revenue_contribution_pct DESC;


-- ============================================================
-- 12. CUMULATIVE REVENUE GENERATED OVER TIME
-- ============================================================

WITH daily_revenue AS (
    SELECT
        o.order_date,
        SUM(od.quantity * p.price) AS daily_revenue
    FROM orders AS o
    JOIN order_details AS od
        ON o.order_id = od.order_id
    JOIN pizzas AS p
        ON od.pizza_id = p.pizza_id
    GROUP BY o.order_date
)
SELECT
    order_date,
    ROUND(daily_revenue, 2) AS daily_revenue,
    ROUND(
        SUM(daily_revenue) OVER (
            ORDER BY order_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS cumulative_revenue
FROM daily_revenue
ORDER BY order_date;


-- ============================================================
-- 13. TOP 3 PIZZA TYPES BY REVENUE WITHIN EACH CATEGORY
-- ============================================================

WITH pizza_revenue AS (
    SELECT
        pt.category,
        pt.name AS pizza_name,
        SUM(od.quantity * p.price) AS total_revenue
    FROM order_details AS od
    JOIN pizzas AS p
        ON od.pizza_id = p.pizza_id
    JOIN pizza_types AS pt
        ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
),
ranked_pizzas AS (
    SELECT
        category,
        pizza_name,
        total_revenue,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_revenue DESC
        ) AS revenue_rank
    FROM pizza_revenue
)
SELECT
    category,
    pizza_name,
    ROUND(total_revenue, 2) AS total_revenue,
    revenue_rank
FROM ranked_pizzas
WHERE revenue_rank <= 3
ORDER BY category, revenue_rank;


-- ============================================================
-- PORTFOLIO KPIs
-- ============================================================

-- Average Order Value (AOV)
SELECT
    ROUND(
        SUM(od.quantity * p.price) /
        COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value
FROM orders AS o
JOIN order_details AS od
    ON o.order_id = od.order_id
JOIN pizzas AS p
    ON od.pizza_id = p.pizza_id;


-- Total pizzas sold
SELECT SUM(quantity) AS total_pizzas_sold
FROM order_details;


-- Revenue by category
SELECT
    pt.category,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details AS od
JOIN pizzas AS p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types AS pt
    ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_revenue DESC;


-- Revenue and quantity by pizza size
SELECT
    p.size,
    ROUND(SUM(od.quantity * p.price), 2) AS total_revenue,
    SUM(od.quantity) AS total_quantity
FROM order_details AS od
JOIN pizzas AS p
    ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_revenue DESC;


-- ============================================================
-- END OF PIZZA SALES ANALYSIS
-- ============================================================
