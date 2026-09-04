USE ContosoRetailDW;
GO

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
ORDER BY TABLE_NAME;

SELECT TOP 10 *
FROM DimDate;

SELECT COUNT(*) AS Sales FROM FactSales;

SELECT COUNT(*) AS Customers FROM DimCustomer;

SELECT COUNT(*) AS Products FROM DimProduct;

SELECT COUNT(*) AS Stores FROM DimStore;

SELECT TOP 10 *
FROM dbo.FactSales;

SELECT TOP 10 *
FROM dbo.FactOnlineSales;