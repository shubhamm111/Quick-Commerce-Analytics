--Customers Who Ordered from only one Platform

WITH Customer_Platform_Count AS (
    SELECT 
        Customer_ID,
        COUNT(DISTINCT Platform) AS Platform_Count
    FROM 
        [dbo].[Ecommerce]
    GROUP BY 
        Customer_ID
),
Customer_Order_Count AS (
    SELECT
        Customer_ID,
        Platform,
        COUNT(*) AS Total_Orders , SUM(Order_Value_INR) AS Total_Order_Value
    FROM
        [dbo].[Ecommerce]
    GROUP BY
        Customer_ID, Platform
)
SELECT 
    C1.Customer_ID,
    C1.Platform,
    C1.Total_Orders,
	c1.Total_Order_Value
FROM 
    Customer_Order_Count C1
JOIN 
    Customer_Platform_Count C2 ON C1.Customer_ID = C2.Customer_ID
WHERE 
    C2.Platform_Count = 1 
ORDER BY 
    C1.Total_Orders DESC, Total_Order_Value DESC;


