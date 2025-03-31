--Most & Least Selling product category on each platform

WITH Product_Counter AS (
    SELECT 
        Platform,
        Product_Category,
        COUNT(Order_Value_INR) AS Count_value
    FROM 
        [dbo].[Ecommerce]
    GROUP BY 
        Platform, 
        Product_Category
), 

Product_Ranker AS (
    SELECT 
        Platform,
        Product_Category,
        Count_value,
        RANK() OVER (PARTITION BY Platform ORDER BY Count_value DESC) AS cnt
    FROM 
        Product_Counter
)

SELECT 
    Platform, 
    MAX(CASE WHEN cnt = 1 THEN Product_Category ELSE NULL END) AS Most_Selling_Category,
    MAX(CASE WHEN cnt = 5 THEN Product_Category ELSE NULL END) AS Least_Selling_Category
FROM 
    Product_Ranker
GROUP BY 
    Platform;