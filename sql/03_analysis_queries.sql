-- =====================================================
--  Business Questions
-- =====================================================

-- BQ 1: Total Sales
SELECT ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore;

-- BQ 2: Total Profit
SELECT ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore;

-- BQ 3: Tren Sales per Tahun
SELECT 
    EXTRACT(YEAR FROM order_date) AS tahun,
    ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY tahun
ORDER BY tahun;

-- BQ 4: Kategori dengan Sales terbesar
SELECT category, ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- BQ 5: Sub-category dengan Profit terbesar
SELECT sub_category, ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit DESC
LIMIT 5;

-- BQ 6: Segmen paling menguntungkan
SELECT segment, ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore
GROUP BY segment
ORDER BY total_profit DESC;

-- BQ 7: Customer dengan Sales terbesar
SELECT customer_name, ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- BQ 8: Region dengan Sales terbesar
SELECT region, ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;


-- =====================================================
--  KPI Analysis
-- =====================================================

-- KPI Ringkasan Utama
SELECT 
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales) * 100)::numeric, 2) AS profit_margin_pct,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND((SUM(sales) / COUNT(DISTINCT order_id))::numeric, 2) AS avg_order_value
FROM superstore;

-- Profit Margin per Category
SELECT 
    category,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales) * 100)::numeric, 2) AS profit_margin_pct
FROM superstore
GROUP BY category
ORDER BY profit_margin_pct DESC;

-- Profit Margin per Sub-Category (cari yang paling boncos)
SELECT 
    sub_category,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    ROUND((SUM(profit) / SUM(sales) * 100)::numeric, 2) AS profit_margin_pct
FROM superstore
GROUP BY sub_category
ORDER BY profit_margin_pct ASC;

-- =====================================================
-- Window Functions
-- =====================================================

-- Ranking Sub-Category berdasarkan Profit dalam tiap Category
SELECT 
    category,
    sub_category,
    ROUND(SUM(profit)::numeric, 2) AS total_profit,
    RANK() OVER (PARTITION BY category ORDER BY SUM(profit) DESC) AS rank_in_category
FROM superstore
GROUP BY category, sub_category
ORDER BY category, rank_in_category;

-- Running Total Sales per Bulan
SELECT 
    DATE_TRUNC('month', order_date) AS bulan,
    ROUND(SUM(sales)::numeric, 2) AS monthly_sales,
    ROUND(SUM(SUM(sales)) OVER (ORDER BY DATE_TRUNC('month', order_date))::numeric, 2) AS running_total
FROM superstore
GROUP BY bulan
ORDER BY bulan;

-- Persentase Kontribusi tiap Category terhadap Total Sales
SELECT 
    category,
    ROUND(SUM(sales)::numeric, 2) AS total_sales,
    ROUND((SUM(sales) / SUM(SUM(sales)) OVER () * 100)::numeric, 2) AS pct_of_total_sales
FROM superstore
GROUP BY category
ORDER BY pct_of_total_sales DESC;

-- Top 3 Customer per Segment (pakai ROW_NUMBER)
SELECT *
FROM (
    SELECT 
        segment,
        customer_name,
        ROUND(SUM(sales)::numeric, 2) AS total_sales,
        ROW_NUMBER() OVER (PARTITION BY segment ORDER BY SUM(sales) DESC) AS rn
    FROM superstore
    GROUP BY segment, customer_name
) ranked
WHERE rn <= 3
ORDER BY segment, rn;

-- =====================================================
-- CTE
-- =====================================================

-- CTE: Cari State dengan Profit Margin terendah (bukan cuma total profit)
WITH state_summary AS (
    SELECT 
        state,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit
    FROM superstore
    GROUP BY state
)
SELECT 
    state,
    ROUND(total_sales::numeric, 2) AS total_sales,
    ROUND(total_profit::numeric, 2) AS total_profit,
    ROUND((total_profit / total_sales * 100)::numeric, 2) AS profit_margin_pct
FROM state_summary
ORDER BY profit_margin_pct ASC
LIMIT 10;

-- CTE: Kategori paling terdampak diskon (gabungan beberapa langkah)
WITH discount_impact AS (
    SELECT 
        category,
        CASE 
            WHEN discount = 0 THEN 'Tanpa Diskon'
            ELSE 'Dengan Diskon'
        END AS status_diskon,
        profit
    FROM superstore
),
summary AS (
    SELECT 
        category,
        status_diskon,
        ROUND(AVG(profit)::numeric, 2) AS avg_profit,
        COUNT(*) AS jumlah_transaksi
    FROM discount_impact
    GROUP BY category, status_diskon
)
SELECT * FROM summary
ORDER BY category, status_diskon;

-- CTE: Customer paling loyal (banyak order) sekaligus paling profitable
WITH customer_stats AS (
    SELECT 
        customer_name,
        COUNT(DISTINCT order_id) AS jumlah_order,
        ROUND(SUM(sales)::numeric, 2) AS total_sales,
        ROUND(SUM(profit)::numeric, 2) AS total_profit
    FROM superstore
    GROUP BY customer_name
)
SELECT *
FROM customer_stats
WHERE jumlah_order >= 5
ORDER BY total_profit DESC
LIMIT 10;