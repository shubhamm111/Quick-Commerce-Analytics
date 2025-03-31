--Percentage of deliveries completed on time

with Total_Orders as (

SELECT 
   PLATFORM, 
    COUNT(*) AS Total_Deliveries
FROM 
    [dbo].[Ecommerce]

    
GROUP BY 
    Platform 
), 

Timely_Delivery as (
SELECT distinct
   E.Platform, 
    COUNT(*) AS Total_Timely_Deliveries, T.Total_Deliveries
FROM 
    [dbo].[Ecommerce] E  inner join Total_Orders T 
	on E.Platform=T.Platform

WHERE  E.Delivery_Delay='No'
    
GROUP BY 
    E.Platform ,T.Total_Deliveries ) 


Select Platform , Total_Timely_Deliveries , Total_Deliveries , 

      ROUND((CAST(Total_Timely_Deliveries AS FLOAT) / CAST(Total_Deliveries AS FLOAT) * 100), 4) AS Percentage_Timely_Deliveries


from Timely_Delivery 

order by Percentage_Timely_Deliveries desc;



