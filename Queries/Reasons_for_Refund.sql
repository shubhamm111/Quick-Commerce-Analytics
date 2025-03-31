-- Identifying Reasons for refunds


WITH AvgDelivery AS (
    SELECT AVG(Delivery_Time_Minutes) AS Avg_Delivery_Time
    FROM [dbo].[Ecommerce]
)


SELECT *
FROM (
    SELECT 
        E.Platform,
        E.Customer_ID,
        CONCAT(
            CASE WHEN E.Delivery_Delay = 'Yes' THEN 'Delivery Delay, ' ELSE '' END,
            CASE WHEN E.Delivery_Time_Minutes > A.Avg_Delivery_Time THEN 'Above Average Delivery Time ' ELSE '' END
        ) AS Refund_Reasons,
        COUNT(*) AS Occurrence_Count
    FROM 
        [dbo].[Ecommerce] E,
        AvgDelivery A
    WHERE 
        E.Refund_Requested = 'Yes'
    GROUP BY 
        E.Platform,
        E.Customer_ID,
        E.Service_Rating,
        E.Delivery_Delay,
        E.Delivery_Time_Minutes,
        E.Product_Category,
        A.Avg_Delivery_Time
) AS SubQuery
WHERE 
    Refund_Reasons != '' 
ORDER BY 
    Occurrence_Count DESC;
