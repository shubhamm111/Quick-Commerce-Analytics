--Top 10 customers by total order value

SELECT 
    Customer_ID,
    SUM(Order_Value_INR) AS Total_Order_Value_INR
FROM 
    [dbo].[Ecommerce]
GROUP BY 
    Customer_ID
ORDER BY 
    Total_Order_Value_INR DESC
OFFSET 0 ROWS 
FETCH NEXT 10 ROWS ONLY;

