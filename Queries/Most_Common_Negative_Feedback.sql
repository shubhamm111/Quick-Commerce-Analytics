-- Most Common Negative Feedback on each Platform

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

Reviews AS (
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
    Customer_Feedback AS Most_Common_Negative_Feedback,
    Feedback_Counter
FROM 
(
    SELECT 
        Platform, 
        Customer_Feedback, 
        Feedback_Counter,
        DENSE_RANK() OVER (PARTITION BY Platform ORDER BY Feedback_Counter DESC) AS dr
    FROM 
        Reviews 
    WHERE 
        Review = 'Negative' 
) AS Ranked_Feedback
WHERE 
    dr = 1;
