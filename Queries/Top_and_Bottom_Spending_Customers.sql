-- Calculate Top and Bottom 10% Spenders on Each Platform

With Top_And_Bottom_Spenders as (

SELECT  Customer_ID , PLATFORM , Order_Value_INR , 
        CUME_DIST()Over(Partition by Platform order by Order_Value_INR ) as Cume_Dist_Rank

FROM 
    [dbo].[Ecommerce] ) 

SELECT 
    Platform,
    SUM(CASE WHEN Cume_Dist_Rank >= 0.9 THEN Order_Value_INR ELSE 0 END) AS Top_10percent_Spenders,
    SUM(CASE WHEN Cume_Dist_Rank <= 0.1 THEN Order_Value_INR ELSE 0 END) AS Least_10percent_Spenders
FROM 
    Top_And_Bottom_Spenders
GROUP BY 
    Platform;   