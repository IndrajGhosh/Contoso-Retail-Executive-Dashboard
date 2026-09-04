/*--------------------------------------------------------
Business Question:
Who are our top 10 customers by revenue?

Dashboard:
Top Customers
--------------------------------------------------------*/

SELECT TOP 10
    c.FirstName + ' ' + c.LastName AS CustomerName,
    SUM(f.SalesAmount) AS Revenue,
    SUM(f.SalesAmount - f.TotalCost) AS Profit,
    SUM(f.SalesQuantity) AS QuantitySold
FROM dbo.FactOnlineSales f
JOIN dbo.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY
    c.FirstName,
    c.LastName
ORDER BY Revenue DESC;

/*--------------------------------------------------------
Business Question:
Which countries generate the highest revenue?
--------------------------------------------------------*/

SELECT
    g.RegionCountryName AS Country,
    SUM(f.SalesAmount) AS Revenue
FROM dbo.FactSales f
INNER JOIN dbo.DimStore s
    ON f.StoreKey = s.StoreKey
INNER JOIN dbo.DimGeography g
    ON s.GeographyKey = g.GeographyKey
GROUP BY g.RegionCountryName
ORDER BY Revenue DESC;

/*--------------------------------------------------------
Business Question:
Revenue by Gender
--------------------------------------------------------*/

SELECT
    c.Gender,
    SUM(f.SalesAmount) AS Revenue
FROM dbo.FactOnlineSales f
JOIN dbo.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY c.Gender;

/*--------------------------------------------------------
Business Question:
How has monthly revenue changed over time?
--------------------------------------------------------*/

SELECT
    d.CalendarYear,
    d.CalendarMonthLabel,
    SUM(f.SalesAmount) AS Revenue,
    LAG(SUM(f.SalesAmount))
        OVER (
            ORDER BY d.CalendarYear, d.CalendarMonth
        ) AS PreviousMonthRevenue
FROM dbo.FactSales f
JOIN dbo.DimDate d
    ON f.DateKey = d.DateKey
GROUP BY
    d.CalendarYear,
    d.CalendarMonth,
    d.CalendarMonthLabel
ORDER BY
    d.CalendarYear,
    d.CalendarMonth;

/*--------------------------------------------------------
Business Question:
Which products generate the highest profit?
--------------------------------------------------------*/

SELECT TOP 10
    p.ProductName,
    SUM(f.SalesAmount - f.TotalCost) AS Profit
FROM dbo.FactSales f
JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY p.ProductName
ORDER BY Profit DESC;