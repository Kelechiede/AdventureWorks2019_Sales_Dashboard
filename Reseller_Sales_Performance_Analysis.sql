use AdventureWorksDW2019

SELECT 
    P.EnglishProductName AS ProductName,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    SUM(FIS.OrderQuantity) AS TotalQuantity,
    SUM(FIS.SalesAmount) AS TotalSales,
    ST.SalesTerritoryRegion,
    ST.SalesTerritoryCountry,
    DD.FullDateAlternateKey AS OrderDate
FROM FactInternetSales FIS
JOIN DimProduct P ON FIS.ProductKey = P.ProductKey
JOIN DimCustomer C ON FIS.CustomerKey = C.CustomerKey
JOIN DimSalesTerritory ST ON FIS.SalesTerritoryKey = ST.SalesTerritoryKey
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
WHERE DD.FullDateAlternateKey >= DATEADD(year, -2, GETDATE()) -- Last two years
GROUP BY P.EnglishProductName, C.FirstName, C.LastName, ST.SalesTerritoryRegion, ST.SalesTerritoryCountry, DD.FullDateAlternateKey
ORDER BY DD.FullDateAlternateKey;

SELECT TOP 10 * FROM FactInternetSales;


select * from DimEmployee
select * from FactInternetSales
select * from DimSalesReason
select * from DimSalesTerritory
select * from FactSalesQuota
select * from FactInternetSales
select * from FactInternetSales



SELECT 
    P.EnglishProductName AS ProductName,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    FIS.OrderQuantity AS TotalQuantity,
    FIS.SalesAmount AS TotalSales,
    ST.SalesTerritoryRegion,
    ST.SalesTerritoryCountry,
    DD.FullDateAlternateKey AS OrderDate
FROM FactInternetSales FIS
JOIN DimProduct P ON FIS.ProductKey = P.ProductKey
JOIN DimCustomer C ON FIS.CustomerKey = C.CustomerKey
JOIN DimSalesTerritory ST ON FIS.SalesTerritoryKey = ST.SalesTerritoryKey
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
---WHERE DD.FullDateAlternateKey >= DATEADD(year, -2, GETDATE()) -- Commented out for testing
WHERE DD.FullDateAlternateKey >= '2019-01-01' -- Adjust the date as per available data
ORDER BY DD.FullDateAlternateKey;



SELECT 
    P.EnglishProductName AS ProductName,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    SUM(FIS.OrderQuantity) AS TotalQuantity,
    SUM(FIS.SalesAmount) AS TotalSales,
    ST.SalesTerritoryRegion,
    ST.SalesTerritoryCountry,
    DD.FullDateAlternateKey AS OrderDate
FROM FactInternetSales FIS
JOIN DimProduct P ON FIS.ProductKey = P.ProductKey
JOIN DimCustomer C ON FIS.CustomerKey = C.CustomerKey
JOIN DimSalesTerritory ST ON FIS.SalesTerritoryKey = ST.SalesTerritoryKey
JOIN DimDate DD ON FIS.OrderDateKey = DD.DateKey
WHERE DD.FullDateAlternateKey >= '2015-01-01' -- Adjusted date
GROUP BY P.EnglishProductName, C.FirstName, C.LastName, ST.SalesTerritoryRegion, ST.SalesTerritoryCountry, DD.FullDateAlternateKey
ORDER BY DD.FullDateAlternateKey;



--- NEW BUSINESS REQUEST: RESELLER SALES PERFORMANCE ANALYSIS
SELECT 
    R.ResellerName,
    ST.SalesTerritoryRegion,
    ST.SalesTerritoryCountry,
    YEAR(DD.FullDateAlternateKey) AS SalesYear,
    SUM(FRS.SalesAmount) AS TotalSalesRevenue,
    SUM(FRS.OrderQuantity) AS TotalQuantitySold
FROM FactResellerSales FRS
JOIN DimReseller R ON FRS.ResellerKey = R.ResellerKey
JOIN DimSalesTerritory ST ON FRS.SalesTerritoryKey = ST.SalesTerritoryKey
JOIN DimDate DD ON FRS.OrderDateKey = DD.DateKey
GROUP BY R.ResellerName, ST.SalesTerritoryRegion, ST.SalesTerritoryCountry, YEAR(DD.FullDateAlternateKey)
ORDER BY ST.SalesTerritoryRegion, ST.SalesTerritoryCountry, YEAR(DD.FullDateAlternateKey), TotalSalesRevenue DESC;
