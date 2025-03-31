-- Identifying the top customers by order_value on each platform


WITH Top_Customers AS (
    SELECT DISTINCT 
        Customer_id,
        Platform,
        SUM(Order_Value_INR) OVER (PARTITION BY Customer_id, Platform) AS Order_value_per_platform
    FROM 
        [dbo].[Ecommerce]
) 
SELECT 
    Customer_id,
    Platform,
    Order_value_per_platform
FROM (
    SELECT 
        Customer_id,
        Order_value_per_platform,
        Platform,
        DENSE_RANK() OVER (PARTITION BY Platform ORDER BY Order_value_per_platform DESC) AS dr
    FROM 
        Top_Customers
) A
WHERE 
    dr = 1;
