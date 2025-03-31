DROP TABLE IF EXISTS Ecommerce;

CREATE TABLE Ecommerce (
    Order_ID VARCHAR(10) PRIMARY KEY,                     -- Custom Order ID 
    Customer_ID VARCHAR(20) NOT NULL,                     -- Customer Identifier 
    Platform VARCHAR(50) NOT NULL,                        -- Platform name (
    Delivery_Time_Minutes FLOAT NOT NULL,                   -- Delivery duration in minutes
    Product_Category VARCHAR(100) NOT NULL,               -- Category of the ordered product
    Order_Value_INR DECIMAL(10,2) NOT NULL,               -- Order value in INR
    Customer_Feedback VARCHAR(255),                       -- Customer feedback comments
    Service_Rating INT CHECK (Service_Rating BETWEEN 1 AND 5), -- Rating between 1 to 5
    Delivery_Delay VARCHAR(3) CHECK (Delivery_Delay IN ('Yes', 'No')), -- Delivery Delay (Yes/No)
    Refund_Requested VARCHAR(3) CHECK (Refund_Requested IN ('Yes', 'No')) -- Refund Requested (Yes/No)
);

--Importing  data from the csv file


BULK INSERT [dbo].[Ecommerce]
From "D:\Analytics\Ecommerce_Delivery_Analytics_New.csv"
WITH (FIRSTROW=2   ,
      FIELDTERMINATOR=',' ,
	  ROWTERMINATOR='\n') ;

--Checking whether data is load properly or not 
Select Top 5 * 
from [dbo].[Ecommerce] ;