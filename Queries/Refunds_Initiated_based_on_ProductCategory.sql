--Refunds Initiated for each product category on different platforms

WITH Refund_Initiated_by_Customers AS (
    SELECT 
        Platform, 
        Product_Category,
        COUNT(*) AS Total_Refund_Requests
    FROM 
        [dbo].[Ecommerce]
    WHERE 
        Refund_Requested = 'Yes'
    GROUP BY 
        Platform, 
        Product_Category
) 

SELECT 
    Platform,
    MAX(CASE WHEN Product_Category = 'Beverages' THEN Total_Refund_Requests ELSE NULL END) AS Beverage_Refunds,
    MAX(CASE WHEN Product_Category = 'Grocery' THEN Total_Refund_Requests ELSE NULL END) AS Grocery_Refunds,
    MAX(CASE WHEN Product_Category = 'Snacks' THEN Total_Refund_Requests ELSE NULL END) AS Snacks_Refunds,
    MAX(CASE WHEN Product_Category = 'Fruits & Vegetables' THEN Total_Refund_Requests ELSE NULL END) AS Fruits_and_Vegetables_Refunds,
    MAX(CASE WHEN Product_Category = 'Personal Care' THEN Total_Refund_Requests ELSE NULL END) AS Personal_Care_Refunds,
	 MAX(CASE WHEN Product_Category = 'Dairy' THEN Total_Refund_Requests ELSE NULL END) AS Dairy_Refunds
FROM 
    Refund_Initiated_by_Customers
GROUP BY 
    Platform;
