-- Classify customers into NPS categories
WITH NPS AS (
    SELECT 
        Customer_ID,
        Platform,
        Service_Rating,
        CASE 
            WHEN Service_Rating <= 2 THEN 'Detractor'
            WHEN Service_Rating = 3 THEN 'Neutral'
            ELSE 'Promoter' 
        END AS NPS_Category
    FROM 
        [dbo].[Ecommerce]
), 

-- Aggregate counts per platform and NPS category
Aggregated_NPS AS (  
    SELECT 
        Platform, 
        NPS_Category, 
        COUNT(*) AS Total_count 
    FROM 
        NPS
    GROUP BY 
        Platform, NPS_Category
) 

-- Pivot and calculate NPS percentages

SELECT 
    Platform,
    
    ROUND(
        (CAST(Neutrals AS FLOAT) * 100.0) / 
        (CAST(Detractors AS FLOAT) + CAST(Neutrals AS FLOAT) + CAST(Promoters AS FLOAT)), 
        2
    ) AS Percentage_Neutrals,

    ROUND(
        (CAST(Promoters AS FLOAT) * 100.0) / 
        (CAST(Detractors AS FLOAT) + CAST(Neutrals AS FLOAT) + CAST(Promoters AS FLOAT)), 
        2
    ) AS Percentage_Promoters ,

	ROUND(
        (CAST(Detractors AS FLOAT) * 100.0) / 
        (CAST(Detractors AS FLOAT) + CAST(Neutrals AS FLOAT) + CAST(Promoters AS FLOAT)), 
        2
    ) AS Percentage_Detractors


FROM (
    SELECT 
        Platform,
        MAX(CASE WHEN NPS_Category = 'Detractor' THEN Total_count ELSE NULL END) AS Detractors,
        MAX(CASE WHEN NPS_Category = 'Neutral' THEN Total_count ELSE NULL END) AS Neutrals,
        MAX(CASE WHEN NPS_Category = 'Promoter' THEN Total_count ELSE NULL END) AS Promoters
    FROM 
        Aggregated_NPS
    GROUP BY 
        Platform
) A;
