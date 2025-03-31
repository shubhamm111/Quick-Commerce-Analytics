-- Customers having maximum number of refund requests

with max_refund as (
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
	
SELECT
    Customer_ID ,
	Total_Refund_Requests

FROM
    max_refund 

WHERE 
    Total_Refund_Requests=(Select MAX(Total_Refund_Requests) from max_refund);
