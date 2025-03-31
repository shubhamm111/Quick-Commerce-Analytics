-- Identifying the platform and product category with the highest refund rate

SELECT 
    Platform, 
    Product_Category, 
    COUNT(*) AS Refund_Requests
FROM 
    [dbo].[Ecommerce]
WHERE  
    Refund_Requested = 'Yes'
GROUP BY 
    Platform, 
    Product_Category
ORDER BY 
    Refund_Requests desc;
