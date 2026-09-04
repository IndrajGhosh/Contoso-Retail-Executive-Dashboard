/*-----------------------------------------
Procedure: usp_MonthlySalesReport
Purpose: Monthly revenue and profit
-----------------------------------------*/

CREATE PROCEDURE usp_MonthlySalesReport
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        d.CalendarYear,
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
        d.CalendarMonthLabel
    ORDER BY
        d.CalendarYear,
        d.CalendarMonth;
END;
GO

EXEC usp_MonthlySalesReport;

