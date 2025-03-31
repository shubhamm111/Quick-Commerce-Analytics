-- Product Categories with the Highest Count on Each Platform Having Above-Average Delivery Time


WITH Avg_Delivery_Time AS (
    SELECT 
        AVG(Delivery_Time_Minutes) AS Avg_Delivery_Time_Minutes 
    FROM 
        [dbo].[Ecommerce]
),  


Products_With_More_than_Avg_Delivery_Time AS (
    SELECT 
        E.Platform, 
        E.Product_Category, 
        COUNT(*) AS Cnt
    FROM 
        [dbo].[Ecommerce] E, 
        Avg_Delivery_Time A
    WHERE 
        E.Delivery_Time_Minutes > A.Avg_Delivery_Time_Minutes
    GROUP BY  
        E.Platform, 
        E.Product_Category
),  

Max_Counts AS (
    SELECT 
        Platform, 
        MAX(Cnt) AS Maxm_Count
    FROM 
        Products_With_More_than_Avg_Delivery_Time
    GROUP BY 
        Platform
)


SELECT 
    P.Platform, 
    P.Product_Category, 
    M.Maxm_Count
FROM 
    Products_With_More_than_Avg_Delivery_Time P 
INNER JOIN  
    Max_Counts M 
ON 
    P.Platform = M.Platform 
    AND P.Cnt = M.Maxm_Count;




 



