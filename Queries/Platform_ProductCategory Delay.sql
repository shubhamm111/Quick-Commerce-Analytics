-- Product Categories experiencing delivery delays


WITH Delay_Counts AS (
    SELECT 
        Platform,  
        Product_Category,  
        COUNT(*) AS Total_Delivery_Delays
    FROM 
        [dbo].[Ecommerce]
    WHERE 
        Delivery_Delay = 'Yes'
    GROUP BY 
        Platform, Product_Category
) 

SELECT 
    Platform, 
    Product_Category,
    Total_Delivery_Delays
FROM (
    SELECT 
        *, 
        DENSE_RANK() OVER (PARTITION BY Product_Category ORDER BY Total_Delivery_Delays DESC) AS Rank_Delay
    FROM 
        Delay_Counts
) AS Ranked_Delays
WHERE 
    Rank_Delay = 1
ORDER BY 
    Platform;
