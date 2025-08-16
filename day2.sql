--Write a SQL query to display:
----1. Previous Day Sales for each salesperson. 
-----2. Next Day Sales for each salesperson. 
---3. Running Total of sales till that date.

CREATE TABLE Sales (
  SaleDate DATE,
  SalesPerson VARCHAR(10),
  Amount INT
);
INSERT INTO Sales (SaleDate, SalesPerson, Amount) VALUES
('2025-08-01', 'A', 200),
('2025-08-02', 'A', 300),
('2025-08-03', 'A', 150),
('2025-08-01', 'B', 400),
('2025-08-02', 'B', 250),
('2025-08-03', 'B', 350);
select * from Sales

select
     SaleDate,
     SalesPerson,
     Amount,
     LAG(Amount) over(partition by SalesPerson ORDER BY Saledate) as previousdays_sales,
     LEAD(Amount) over(partition by SalesPerson order by Saledate) as nextday_sales,
     SUM(Amount)  over(partition by SalesPerson order by Saledate rows between unbounded Preceding  and current row) as running_total 
   from Sales
   order by
           SalesPerson,
           SaleDate;


   -----------------------------
WITH SalesWithMetrics AS (
  SELECT 
    SaleDate,
    SalesPerson,
    Amount,
    LAG(Amount) OVER (PARTITION BY SalesPerson ORDER BY SaleDate) AS PreviousDaySales,
    LEAD(Amount) OVER (PARTITION BY SalesPerson ORDER BY SaleDate) AS NextDaySales,
    SUM(Amount) OVER (PARTITION BY SalesPerson ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
  FROM 
    Sales
)
SELECT 
  SaleDate,
  SalesPerson,
  Amount,
  PreviousDaySales,
  NextDaySales,
  RunningTotal
FROM 
  SalesWithMetrics
ORDER BY 
  SalesPerson, SaleDate;