-- Identify customers with consistent low service ratings (<=3)

WITH Order_Count AS (
    SELECT 
        Customer_ID,
        COUNT(*) AS Total_Orders
    FROM 
        [dbo].[Ecommerce]
    GROUP BY 
        Customer_ID
), 

Low_ratings AS (
    SELECT 
        Customer_ID,
        COUNT(*) AS Total_Poor_Ratings
    FROM 
        [dbo].[Ecommerce]
    WHERE
        Service_Rating <= 3
    GROUP BY 
        Customer_ID
), 

Refund_Initiated AS (
    SELECT 
        Customer_ID,
        COUNT(*) AS Total_Refund_Requests
    FROM 
        [dbo].[Ecommerce]
    WHERE 
        Refund_Requested = 'Yes'
    GROUP BY 
        Customer_ID
)


SELECT TOP 10
    L.Customer_ID,
    O.Total_Orders,
    L.Total_Poor_Ratings,
    R.Total_Refund_Requests
FROM 
    Low_ratings L
INNER JOIN 
    Refund_Initiated R ON L.Customer_ID = R.Customer_ID
INNER JOIN 
    Order_Count O ON L.Customer_ID = O.Customer_ID

WHERE O.Total_Orders=L.Total_Poor_Ratings

ORDER BY 
    L.Total_Poor_Ratings DESC,
    R.Total_Refund_Requests DESC;
