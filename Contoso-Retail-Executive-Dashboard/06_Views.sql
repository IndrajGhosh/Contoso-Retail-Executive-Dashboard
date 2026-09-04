/*-----------------------------------------
View: vw_ProductPerformance
Purpose: Product sales summary
-----------------------------------------*/
DROP VIEW vw_ProductPerformance;
GO
CREATE VIEW vw_ProductPerformance AS
SELECT
	YEAR(f.DateKey) AS "YEAR",
    p.ProductKey,
    p.ProductName,
    SUM(f.SalesQuantity) AS QuantitySold,
    SUM(f.SalesAmount) AS Revenue,
    SUM(f.TotalCost) AS Cost,
    SUM(f.SalesAmount - f.TotalCost) AS Profit
FROM dbo.FactSales f
JOIN dbo.DimProduct p
    ON f.ProductKey = p.ProductKey
GROUP BY
    p.ProductKey,
    p.ProductName,
	YEAR(f.DateKey);
GO

/*-----------------------------------------
View: vw_MonthlySales
Purpose: Monthly sales trend
-----------------------------------------*/

DROP VIEW vw_MonthlySales;
GO
CREATE VIEW vw_MonthlySales AS
SELECT
    d.CalendarYear,
    d.CalendarMonth,
    d.CalendarMonthLabel,
    SUM(f.SalesAmount) AS Revenue,
    SUM(f.TotalCost) AS Cost,
    SUM(f.SalesAmount - f.TotalCost) AS Profit
FROM dbo.FactSales f
JOIN dbo.DimDate d
    ON f.DateKey = d.DateKey
GROUP BY
    d.CalendarYear,
    d.CalendarMonth,
    d.CalendarMonthLabel;
GO

/*-----------------------------------------
View: vw_StorePerformance
Purpose: Store sales summary
-----------------------------------------*/

DROP VIEW vw_StorePerformance;
GO
CREATE VIEW vw_StorePerformance AS
SELECT
	YEAR(f.DateKey) AS "YEAR",
    s.StoreKey,
    s.StoreName,
    SUM(f.SalesAmount) AS Revenue,
    SUM(f.TotalCost) AS Cost,
    SUM(f.SalesAmount - f.TotalCost) AS Profit,
    SUM(f.SalesQuantity) AS QuantitySold
FROM dbo.FactSales f
JOIN dbo.DimStore s
    ON f.StoreKey = s.StoreKey
GROUP BY
    s.StoreKey,
    s.StoreName,
	YEAR(f.DateKey);
GO

/*-----------------------------------------
View: vw_CustomerPerformance
Purpose: Customer sales summary
-----------------------------------------*/

DROP VIEW vw_CustomerPerformance;
GO
CREATE VIEW vw_CustomerPerformance AS
SELECT
	YEAR(f.DateKey) AS "YEAR",
    c.CustomerKey,
    c.FirstName,
    c.LastName,
    SUM(f.SalesAmount) AS Revenue,
    SUM(f.TotalCost) AS Cost,
    SUM(f.SalesAmount - f.TotalCost) AS Profit,
    SUM(f.SalesQuantity) AS QuantitySold
FROM dbo.FactOnlineSales f
JOIN dbo.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
GROUP BY
    c.CustomerKey,
    c.FirstName,
    c.LastName,
	YEAR(f.DateKey);
GO

/*-----------------------------------------
View: vw_ExecutiveSummary
Purpose: Executive KPIs
-----------------------------------------*/

DROP VIEW vw_ExecutiveSummary;
GO
CREATE VIEW vw_ExecutiveSummary AS
SELECT
	YEAR(DateKey) AS "YEAR",
	MONTH(DateKey) AS "MONTH NUM",
	DATENAME(month, DateKey) AS "MONTH",
    SUM(SalesAmount) AS Revenue,
    SUM(TotalCost) AS Cost,
    SUM(SalesAmount - TotalCost) AS Profit,
    SUM(SalesQuantity) AS QuantitySold,
    COUNT(*) AS Transactions
FROM dbo.FactSales
GROUP BY YEAR(DateKey), DATENAME(month, DateKey), MONTH(DateKey);
GO


SELECT TOP 10 *
FROM DimDate;