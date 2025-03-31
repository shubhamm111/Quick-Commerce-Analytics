-- Platforms with their count of ratings for each star level
WITH Platform_Rating AS (
    SELECT 
        Platform, 
        Service_Rating, 
        COUNT(*) AS Ratings_Count
    FROM 
        [dbo].[Ecommerce]
    GROUP BY 
        Platform, Service_Rating 
) 

SELECT 
    Platform,
    MAX(CASE WHEN Service_Rating = 5 THEN Ratings_Count ELSE NULL END) AS Five_Star_Deliveries,
    MAX(CASE WHEN Service_Rating = 4 THEN Ratings_Count ELSE NULL END) AS Four_Star_Deliveries,
    MAX(CASE WHEN Service_Rating = 3 THEN Ratings_Count ELSE NULL END) AS Three_Star_Deliveries,
    MAX(CASE WHEN Service_Rating = 2 THEN Ratings_Count ELSE NULL END) AS Two_Star_Deliveries,
    MAX(CASE WHEN Service_Rating = 1 THEN Ratings_Count ELSE NULL END) AS One_Star_Deliveries
FROM 
    Platform_Rating
GROUP BY 
    Platform
ORDER BY 
    Five_Star_Deliveries DESC;
