-- Products with Above Average Delivery Time by Platform

WITH Product_Wise_Average_Delivery_Time AS (
    SELECT 
        Platform,
        Product_Category,
       ROUND(AVG(Delivery_Time_Minutes), 2) AS Average_Delivery_Time
    FROM 
        [dbo].[Ecommerce]
    GROUP BY 
        Platform, Product_Category
),

Overall_Avg_Delivery_Time AS (
    SELECT 
        ROUND(AVG(Delivery_Time_Minutes), 2) AS Avg_Delivery_Time_Minutes
    FROM 
        [dbo].[Ecommerce] 
)

SELECT 
    P.Platform,
    P.Product_Category,
    Round(P.Average_Delivery_Time-A.Avg_Delivery_Time_Minutes,2) as Delay_Duration
FROM 
    Product_Wise_Average_Delivery_Time P,
    Overall_Avg_Delivery_Time A
WHERE 
    P.Average_Delivery_Time > A.Avg_Delivery_Time_Minutes
ORDER BY 
    P.Platform;
