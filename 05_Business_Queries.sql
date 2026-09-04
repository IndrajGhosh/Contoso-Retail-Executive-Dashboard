/*-----------------------------------------
Query 16: Most Profitable Stores
Purpose: Rank stores by profit.
Visual : Bar Chart
-----------------------------------------*/

SELECT TOP 10
    s.StoreName,
    SUM(f.SalesAmount - f.TotalCost) AS Profit
FROM dbo.FactSales f
JOIN dbo.DimStore s
    ON f.StoreKey = s.StoreKey
GROUP BY s.StoreName
ORDER BY Profit DESC;

/*-----------------------------------------
Query 17: Sales by Channel
Purpose: Compare revenue by sales channel.
Visual : Donut Chart
-----------------------------------------*/

SELECT
    c.ChannelName,
    SUM(f.SalesAmount) AS Revenue
FROM dbo.FactSales f
JOIN dbo.DimChannel c
    ON f.ChannelKey = c.ChannelKey
GROUP BY c.ChannelName
ORDER BY Revenue DESC;

/*-----------------------------------------
Query 18: Top Selling Products
Purpose: Rank products by quantity sold.
Visual : Bar Chart
-----------------------------------------*/

SELECT TOP 10
    p.ProductName,
    SUM(f.SalesQuantity) AS QuantitySold
FROM dbo.FactSales f
JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName
ORDER BY QuantitySold DESC;

/*-----------------------------------------
Query 19: Profit Margin by Category
Purpose: Compare category profitability.
Visual : Column Chart
-----------------------------------------*/

SELECT
    pc.ProductCategoryName,
    SUM(f.SalesAmount) AS Revenue,
    SUM(f.SalesAmount - f.TotalCost) AS Profit,
    ROUND(
        SUM(f.SalesAmount - f.TotalCost) * 100.0 /
        SUM(f.SalesAmount), 2
    ) AS ProfitMargin
FROM dbo.FactSales f
JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey
JOIN dbo.DimProductSubcategory ps
    ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
JOIN dbo.DimProductCategory pc
    ON ps.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY pc.ProductCategoryName
ORDER BY ProfitMargin DESC;

/*-----------------------------------------
Query 20: Year-over-Year Revenue
Purpose: Compare yearly sales performance.
Visual : Line Chart
-----------------------------------------*/

SELECT
    d.CalendarYear,
    SUM(f.SalesAmount) AS Revenue
FROM dbo.FactSales f
JOIN dbo.DimDate d
    ON f.DateKey = d.DateKey
GROUP BY d.CalendarYear
ORDER BY d.CalendarYear;