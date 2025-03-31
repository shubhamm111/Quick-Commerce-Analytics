--Top Customers on each Platform based on their Order Count

WITH max_orders AS (
    SELECT DISTINCT
        Customer_id,
        Platform,
        COUNT(*) OVER (PARTITION BY Customer_id, Platform) AS Order_Count
    FROM 
        [dbo].[Ecommerce] 
),
MaxCount AS (
    SELECT 
        Customer_id,
        Platform,
        Order_Count,
        DENSE_RANK() OVER (PARTITION BY Platform ORDER BY Order_Count DESC) AS Max_Order_Rank
    FROM 
        max_orders
)
SELECT 
    Platform,
    STRING_AGG(Customer_id, ',') AS Customer_Id,
	Order_Count
FROM 
    MaxCount
WHERE 
    Max_Order_Rank = 1
GROUP BY 
    Platform,Order_Count;





