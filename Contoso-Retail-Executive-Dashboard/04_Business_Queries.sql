/*===========================================================
Query 11: Revenue by Store Type
=============================================================

Business Question:
Which store types generate the highest revenue?

Purpose:
Compare sales performance across different store formats
to identify the best-performing business model.

Power BI Visual:
Clustered Column Chart

Tables Used:
- FactSales
- DimStore

Concepts:
- INNER JOIN
- GROUP BY
- SUM()
===========================================================*/

SELECT
    s.StoreType,
    SUM(f.SalesAmount) AS Revenue
FROM dbo.FactSales f
JOIN dbo.DimStore s
    ON f.StoreKey = s.StoreKey
GROUP BY s.StoreType
ORDER BY Revenue DESC;


/*===========================================================
Query 12: Discount & Returns Analysis
=============================================================

Business Question:
How much revenue is lost due to discounts and returns?

Purpose:
Measure the impact of discounts and product returns on
overall profitability.

Power BI Visual:
KPI Cards

Tables Used:
- FactSales

Concepts:
- Aggregate Functions
- SUM()
===========================================================*/

SELECT
    SUM(DiscountAmount) AS TotalDiscount,
    SUM(ReturnAmount) AS TotalReturns,
    SUM(SalesAmount) AS Revenue
FROM dbo.FactSales;

/*===========================================================
Query 13: Promotion Effectiveness
=============================================================

Business Question:
Which promotions generate the highest revenue?

Purpose:
Evaluate promotional campaigns based on revenue and
transaction count.

Power BI Visual:
Horizontal Bar Chart

Tables Used:
- FactSales
- DimPromotion

Concepts:
- JOIN
- GROUP BY
- COUNT()
- SUM()
===========================================================*/

SELECT
    p.PromotionName,
    COUNT(*) AS Transactions,
    SUM(f.SalesAmount) AS Revenue
FROM dbo.FactSales f
JOIN dbo.DimPromotion p
    ON f.PromotionKey = p.PromotionKey
GROUP BY p.PromotionName
ORDER BY Revenue DESC;

/*===========================================================
Query 14: Best Sales Month
=============================================================

Business Question:
Which month generates the highest revenue?

Purpose:
Identify seasonality and peak sales periods.

Power BI Visual:
Column Chart

Tables Used:
- FactSales
- DimDate

Concepts:
- JOIN
- GROUP BY
- ORDER BY
===========================================================*/

SELECT
    d.CalendarMonthLabel,
    SUM(f.SalesAmount) AS Revenue
FROM dbo.FactSales f
JOIN dbo.DimDate d
    ON f.DateKey = d.DateKey
GROUP BY d.CalendarMonthLabel
ORDER BY Revenue DESC;

/*===========================================================
Query 15: Average Sales per Store
=============================================================

Business Question:
Which stores generate the highest average sales per
transaction?

Purpose:
Compare average sales performance across stores.

Power BI Visual:
Bar Chart

Tables Used:
- FactSales
- DimStore

Concepts:
- AVG()
- JOIN
- GROUP BY
===========================================================*/

SELECT
    s.StoreName,
    AVG(f.SalesAmount) AS AvgSales
FROM dbo.FactSales f
JOIN dbo.DimStore s
    ON f.StoreKey = s.StoreKey
GROUP BY s.StoreName
ORDER BY AvgSales DESC;