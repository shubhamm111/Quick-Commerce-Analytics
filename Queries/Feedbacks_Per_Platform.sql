--Positive and Negative Feedbacks on each Platform

CREATE VIEW Feedback_View AS

WITH Feedbacks AS (
    SELECT 
        Platform,
        Customer_Feedback, 
        COUNT(*) AS Feedback_Counter 
    FROM 
        [dbo].[Ecommerce] 
    GROUP BY 
        Platform, 
        Customer_Feedback
), 

Review AS (
    SELECT 
        Platform,
        Customer_Feedback, 
        Feedback_Counter, 
        CASE 
            WHEN Customer_Feedback IN (
                'Fast delivery great service', 
                'Quick and reliable',
                'Very satisfied with the service',
                'Excellent experience',
                'Good quality products',
                'Easy to order loved it'
            ) THEN 'Positive' 
            ELSE 'Negative' 
        END AS Review
    FROM  
        Feedbacks
)

SELECT 
    Platform, 
    Review, 
    SUM(Feedback_Counter) AS Total_Feedbacks 
FROM 
    Review 
GROUP BY  
    Platform, 
    Review;

--Finding Positive to negative Feedback Percentage

with view_cte as(

Select Platform , 
        max(case when Review='Positive' then Total_Feedbacks else null end) as Positive_Feedbacks ,
	    max(case when Review='Negative' then  Total_Feedbacks else null end) as Negative_Feedbacks


from Feedback_View

group by Platform ) 

Select Platform , 
       Round(cast(Positive_Feedbacks as Float)/cast(Negative_Feedbacks as Float),2) as Positive_to_Negative_Feedback_Ratio 
from view_cte;
