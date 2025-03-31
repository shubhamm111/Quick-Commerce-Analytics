--Average order value for each product category 
With Avg_Order_Value as (
SELECT 
        Platform,
        Product_Category,
        ROund(AVG(CAST( Order_Value_INR as FLoat)),2) as Avg_Value
    FROM 
        [dbo].[Ecommerce]
    WHERE 
        Refund_Requested = 'Yes'
    GROUP BY 
      Platform , Product_Category ) 
SELECT 
    Platform,
    MAX(CASE WHEN Product_Category = 'Beverages' THEN Avg_Value ELSE NULL END) AS Average_Beverages_Order,
    MAX(CASE WHEN Product_Category = 'Grocery' THEN Avg_Value ELSE NULL END) AS Average_Grocery_Order,
    MAX(CASE WHEN Product_Category = 'Snacks' THEN Avg_Value ELSE NULL END) AS Average_Snacks_Order,
    MAX(CASE WHEN Product_Category = 'Fruits & Vegetables' THEN Avg_Value ELSE NULL END) AS Average_Fruits_and_Vegetables_order,
    MAX(CASE WHEN Product_Category = 'Personal Care' THEN Avg_Value ELSE NULL END) AS Average_Personal_Care_Order,
	MAX(CASE WHEN Product_Category = 'Dairy' THEN Avg_Value ELSE NULL END) AS Average_Dairy_Order
FROM 
    Avg_Order_Value
GROUP BY 
    Platform;