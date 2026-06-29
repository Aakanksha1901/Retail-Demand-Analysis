CREATE DATABASE RetailDemand;
USE RetailDemand;

SELECT COUNT(*) FROM retail_demand_cleaned;

-- Average sales by store type.

SELECT
    storetype,
    AVG(sales) AS AverageSales
FROM retail_demand_cleaned
GROUP BY storetype;


-- Store with the highest sales.
SELECT *
FROM retail_demand_cleaned
WHERE sales = (
    SELECT MAX(sales)
    FROM retail_demand_cleaned
);


-- Store with the lowest sales.
SELECT *
FROM retail_demand_cleaned
WHERE sales = (
    SELECT MIN(sales)
    FROM retail_demand_cleaned
);


-- Total sales.
SELECT
    SUM(sales) AS TotalSales
FROM retail_demand_cleaned;

-- Total customers by store.
SELECT
    store,
    SUM(customers) AS TotalCustomers
FROM retail_demand_cleaned
GROUP BY store;

-- Stores with average sales greater than 5000.
SELECT
    store,
    AVG(sales) AS AverageSales
FROM retail_demand_cleaned
GROUP BY store
HAVING AVG(sales) > 5000;

-- Number of records for each store.
SELECT
    store,
    COUNT(*) AS TotalRecords
FROM retail_demand_cleaned
GROUP BY store;

-- Stores having more than 900 records.
SELECT
    store,
    COUNT(*) AS TotalRecords
FROM retail_demand_cleaned
GROUP BY store
HAVING COUNT(*) > 100;


-- Total sales by store type.
SELECT
    storetype,
    SUM(sales) AS TotalSales
FROM retail_demand_cleaned
GROUP BY storetype;


-- Stores that were never open.
SELECT DISTINCT store
FROM retail_demand_cleaned
WHERE store NOT IN (
    SELECT store
    FROM retail_demand_cleaned
    WHERE open = 0
);


-- Total sales by month.
SELECT
    month,
    SUM(sales) AS TotalSales
FROM retail_demand_cleaned
GROUP BY month
ORDER BY month;

-- Days where sales are above the average sales.
SELECT *FROM retail_demand_cleaned
WHERE sales >
(
    SELECT AVG(sales)
    FROM retail_demand_cleaned
);

-- Second highest sales.
SELECT
    MAX(sales) AS SecondHighestSales
FROM retail_demand_cleaned
WHERE sales <
(
    SELECT MAX(sales)
    FROM retail_demand_cleaned
);

-- Categorize stores based on sales.
SELECT
    store,
    sales,
    CASE
        WHEN sales > 10000 THEN 'High'
        WHEN sales BETWEEN 5000 AND 10000 THEN 'Medium'
        ELSE 'Low'
    END AS SalesCategory
FROM retail_demand_cleaned;


-- Rank stores based on sales.

SELECT
    store,
    sales,
    RANK() OVER(ORDER BY sales DESC) AS SalesRank
FROM retail_demand_cleaned;


-- Running total of sales by date.

SELECT
    date,
    SUM(sales) OVER(ORDER BY date) AS RunningTotal
FROM retail_demand_cleaned;


-- Top 5 stores by total sales.

SELECT
    store,
    SUM(sales) AS TotalSales
FROM retail_demand_cleaned
GROUP BY store
ORDER BY TotalSales DESC
LIMIT 5;


-- Stores with total sales greater than the average store sales.

SELECT
    store,
    SUM(sales) AS TotalSales
FROM retail_demand_cleaned
GROUP BY store
HAVING SUM(sales) >
(
    SELECT AVG(StoreSales)
    FROM
    (
        SELECT
            SUM(sales) AS StoreSales
        FROM retail_demand_cleaned
        GROUP BY store
    ) AS AvgSales
);


-- Average customers by store type.

SELECT
    storetype,
    AVG(customers) AS AverageCustomers
FROM retail_demand_cleaned
GROUP BY storetype;


-- Total sales on weekends.

SELECT
    SUM(sales) AS WeekendSales
FROM retail_demand_cleaned
WHERE is_weekend = 1;






