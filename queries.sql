-- ============================================================================
-- 1. Total Revenue
-- ============================================================================

SELECT
    ROUND(SUM(sales_amount),2) AS Total_Revenue
FROM transactions;



-- ============================================================================
-- 2. Total Sales Quantity
-- ============================================================================

SELECT
    SUM(sales_qty) AS Total_Sales_Quantity
FROM transactions;



-- ============================================================================
-- 3. Revenue by Market
-- ============================================================================

SELECT
    m.markets_name,
    ROUND(SUM(t.sales_amount),2) AS Revenue
FROM transactions t
JOIN markets m
ON t.market_code = m.markets_code
GROUP BY m.markets_name
ORDER BY Revenue DESC;



-- ============================================================================
-- 4. Sales Quantity by Market
-- ============================================================================

SELECT
    m.markets_name,
    SUM(t.sales_qty) AS Sales_Quantity
FROM transactions t
JOIN markets m
ON t.market_code = m.markets_code
GROUP BY m.markets_name
ORDER BY Sales_Quantity DESC;



-- ============================================================================
-- 5. Top 5 Customers by Revenue
-- ============================================================================

SELECT
    c.customer_name,
    ROUND(SUM(t.sales_amount),2) AS Revenue
FROM transactions t
JOIN customers c
ON t.customer_code = c.customer_code
GROUP BY c.customer_name
ORDER BY Revenue DESC
LIMIT 5;



-- ============================================================================
-- 6. Monthly Revenue Trend
-- ============================================================================

SELECT
    d.year,
    d.month_name,
    ROUND(SUM(t.sales_amount),2) AS Monthly_Revenue
FROM transactions t
JOIN date d
ON t.order_date = d.date
GROUP BY
    d.year,
    d.month_name
ORDER BY
    d.year,
    MIN(d.date);



-- ============================================================================
-- 7. Top 10 Products by Revenue
-- ============================================================================

SELECT
    p.product_code,
    ROUND(SUM(t.sales_amount),2) AS Revenue
FROM transactions t
JOIN products p
ON t.product_code = p.product_code
GROUP BY p.product_code
ORDER BY Revenue DESC
LIMIT 10;



-- ============================================================================
-- 8. Average Revenue Per Customer
-- ============================================================================

SELECT
    ROUND(AVG(Customer_Revenue),2) AS Avg_Revenue_Per_Customer
FROM
(
    SELECT
        customer_code,
        SUM(sales_amount) AS Customer_Revenue
    FROM transactions
    GROUP BY customer_code
) AS customer_summary;



-- ============================================================================
-- 9. Top Performing Markets
-- ============================================================================

SELECT
    m.markets_name,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(t.sales_amount),2) AS Revenue
FROM transactions t
JOIN markets m
ON t.market_code = m.markets_code
GROUP BY m.markets_name
ORDER BY Revenue DESC;



-- ============================================================================
-- 10. Revenue Contribution by Market
-- ============================================================================

SELECT
    m.markets_name,
    ROUND(SUM(t.sales_amount),2) AS Revenue,
    ROUND(
        SUM(t.sales_amount) * 100 /
        (SELECT SUM(sales_amount) FROM transactions),
        2
    ) AS Revenue_Percentage
FROM transactions t
JOIN markets m
ON t.market_code = m.markets_code
GROUP BY m.markets_name
ORDER BY Revenue DESC;



-- ============================================================================
-- 11. Year-wise Revenue
-- ============================================================================

SELECT
    d.year,
    ROUND(SUM(t.sales_amount),2) AS Revenue
FROM transactions t
JOIN date d
ON t.order_date = d.date
GROUP BY d.year
ORDER BY d.year;



-- ============================================================================
-- 12. Market Performance Summary
-- ============================================================================

SELECT
    m.markets_name,
    COUNT(DISTINCT t.customer_code) AS Customers,
    COUNT(DISTINCT t.product_code) AS Products_Sold,
    SUM(t.sales_qty) AS Total_Quantity,
    ROUND(SUM(t.sales_amount),2) AS Revenue
FROM transactions t
JOIN markets m
ON t.market_code = m.markets_code
GROUP BY m.markets_name
ORDER BY Revenue DESC;