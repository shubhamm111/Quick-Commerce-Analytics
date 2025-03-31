-- Identify platforms with frequent delivery delays and related refund requests

-- Total number of delivery delays per platform
WITH Delays AS (
    SELECT 
        Platform,
        COUNT(*) AS delay_counts
    FROM 
        [dbo].[Ecommerce]
    WHERE  
        Delivery_Delay = 'Yes'
    GROUP BY 
        Platform
), 

-- Total number of refund requests where a delivery delay occurred
Refund_Requests AS (
    SELECT 
        Platform,
        COUNT(*) AS Total_Refund_Requests
    FROM 
        [dbo].[Ecommerce]
    WHERE 
        Refund_Requested = 'Yes' 
        AND Delivery_Delay = 'Yes'
    GROUP BY 
        Platform
)  

-- Retrieve platform details, total delay counts, refund requests and Percentage refund requests
SELECT 
    D.Platform AS Platform,
    D.delay_counts AS Total_Delay_Counts,
    R.Total_Refund_Requests AS Total_Refund_Requests,  
    ROUND(CAST(R.Total_Refund_Requests AS FLOAT) / CAST(D.delay_counts AS FLOAT) * 100,2) AS Percentage_Refund_Requests
FROM 
    Delays D 
JOIN 
    Refund_Requests R 
ON 
    D.Platform = R.Platform

ORDER BY Percentage_Refund_Requests ;
