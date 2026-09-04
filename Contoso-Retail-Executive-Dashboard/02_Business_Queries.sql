/*--------------------------------------------------------
Business Question:
What is the overall sales performance of the company?

Purpose:
Provides KPI cards for the Executive Dashboard.

Expected Output:
Revenue
Cost
Profit
Quantity Sold
Transactions
Average Transaction Value
--------------------------------------------------------*/

SELECT
    SUM(SalesAmount) AS TotalRevenue,
    SUM(TotalCost) AS TotalCost,
    SUM(SalesAmount - TotalCost) AS TotalProfit,
    SUM(SalesQuantity) AS TotalQuantitySold,
    COUNT(*) AS TotalTransactions,
    AVG(SalesAmount) AS AvgTransactionValue
FROM dbo.FactSales;

SELECT
    d.CalendarYear,
    SUM(f.SalesAmount) AS TotalRevenue
FROM dbo.FactSales f
JOIN dbo.DimDate d
    ON f.DateKey = d.Datekey
GROUP BY d.CalendarYear
ORDER BY d.CalendarYear;

/*--------------------------------------------------------
Business Question:
How have sales changed month by month?

Purpose:
Identify seasonality and monthly trends.

Dashboard Visual:
Line Chart
--------------------------------------------------------*/

SELECT
    d.CalendarYear,
    d.CalendarMonthLabel,
    SUM(f.SalesAmount) AS TotalRevenue
FROM dbo.FactSales f
JOIN dbo.DimDate d
    ON f.DateKey = d.DateKey
GROUP BY
    d.CalendarYear,
    d.CalendarMonthLabel,
    d.CalendarMonth
ORDER BY
    d.CalendarYear,
    d.CalendarMonth;

/*--------------------------------------------------------
Business Question:
Which products generate the highest revenue?

Purpose:
Identify best-selling products.

Dashboard Visual:
Top 10 Bar Chart
--------------------------------------------------------*/

SELECT TOP 10
    p.ProductName,
    SUM(f.SalesAmount) AS Revenue,
    SUM(f.SalesQuantity) AS QuantitySold,
    SUM(f.SalesAmount - f.TotalCost) AS Profit
FROM dbo.FactSales f
INNER JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName
ORDER BY Revenue DESC;

/*--------------------------------------------------------
Business Question:
Which product categories generate the most revenue?

Dashboard Visual:
Column Chart
--------------------------------------------------------*/

SELECT
    pc.ProductCategoryName,
    SUM(f.SalesAmount) AS Revenue,
    SUM(f.SalesAmount - f.TotalCost) AS Profit
FROM dbo.FactSales f
JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey
JOIN dbo.DimProductSubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
JOIN dbo.DimProductCategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY pc.ProductCategoryName
ORDER BY Revenue DESC;

/*--------------------------------------------------------
Business Question:
Which stores have the highest sales?

Dashboard Visual:
Top Stores
--------------------------------------------------------*/

SELECT TOP 10
    s.StoreName,
    SUM(f.SalesAmount) AS Revenue,
    SUM(f.SalesAmount - f.TotalCost) AS Profit
FROM dbo.FactSales f
JOIN dbo.DimStore s
    ON f.StoreKey = s.StoreKey
GROUP BY s.StoreName
ORDER BY Revenue DESC;


