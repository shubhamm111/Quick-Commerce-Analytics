-- Product categories which generate the highest revenue on different platforms.

SELECT 
    Platform,
    Product_Category,
    SUM(Order_Value_INR) AS Total_order_value
FROM 
    [dbo].[Ecommerce]
GROUP BY 
    Platform, 
    Product_Category
ORDER BY 
    Platform,
    Total_order_value DESC;
 
