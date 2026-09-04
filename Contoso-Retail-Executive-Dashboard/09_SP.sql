/*-----------------------------------------
Procedure: usp_SalesByYear
Purpose: Sales for a selected year
-----------------------------------------*/

CREATE PROCEDURE usp_SalesByYear
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        d.CalendarMonthLabel,
        SUM(f.SalesAmount) AS Revenue
    FROM dbo.FactSales f
    JOIN dbo.DimDate d
        ON f.DateKey = d.DateKey
    WHERE d.CalendarYear = @Year
    GROUP BY
        d.CalendarMonth,
        d.CalendarMonthLabel
    ORDER BY
        d.CalendarMonth;
END;
GO

EXEC usp_SalesByYear @Year = 2008;