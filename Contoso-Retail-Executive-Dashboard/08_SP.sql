/*-----------------------------------------
Procedure: usp_TopProducts
Purpose: Top 10 products by revenue
-----------------------------------------*/

CREATE PROCEDURE usp_TopProducts
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP 10
        p.ProductName,
        SUM(f.SalesAmount) AS Revenue,
        SUM(f.SalesAmount - f.TotalCost) AS Profit
    FROM dbo.FactSales f
    JOIN dbo.DimProduct p
        ON f.ProductKey = p.ProductKey
    GROUP BY p.ProductName
    ORDER BY Revenue DESC;
END;
GO

EXEC usp_TopProducts;