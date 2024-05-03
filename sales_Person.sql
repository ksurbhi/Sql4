# Solution Without using CTE
SELECT name
FROM SalesPerson
WHERE sales_id NOT IN (
    SELECT DISTINCT o.sales_id
    FROM Orders o
    LEFT JOIN Company c ON o.com_id = c.com_id
    WHERE c.name = 'RED'   
);

# Solution using CTE

WITH CTE AS(
    SELECT DISTINCT o.sales_id
    FROM Orders o
    LEFT JOIN Company c ON o.com_id = c.com_id
    WHERE c.name = 'RED'
)
SELECT s.name 
FROM SalesPerson s
WHERE s.sales_id NOT IN (
    SELECT sales_id FROM CTE 
)
