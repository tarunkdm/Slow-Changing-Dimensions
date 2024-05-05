SQL Queries for Slow Changing Dimension Type II Implementation

1. Create Staging and Dimension Tables:

-- Create Staging Table to temporarily hold incoming data.
CREATE TABLE product_stg(
    Product_id  INT,
    Product_Name VARCHAR(50),
    Price   DECIMAL(9,2)
);


-- Create Dimension Table to store historical data with start and end dates for each record.
CREATE TABLE product_dim(
    product_key int identity(1,1) primary key,
    Product_id  INT,
    Product_Name VARCHAR(50),
    Price   DECIMAL(9,2),
    start_date date,
    end_date date
);


2. Insert Sample Data into Staging Table:

-- Insert sample data into the staging table for testing and demonstration purposes.
INSERT INTO Product_stg Values
(1,'Iphone13', 40000), 
(2, 'Iphone14', 70000);
3. Display Contents of Dimension and Staging Tables:


3. Update Dimension Table with Staging Data (End Date for Existing Records):

-- Declare a variable to store today's date.
DECLARE @today DATE;
SET @today = CAST(GETDATE() AS DATE);

-- Update existing records in the dimension table with an end date of yesterday's date.
-- This marks the end of validity for the existing records.
UPDATE product_dim
SET end_date = DATEADD(day, -1, @today)
FROM product_stg 
WHERE product_stg.product_id = product_dim.product_id
AND product_dim.end_date = '9999-12-31';

4. Insert New Records into Dimension Table from Staging (Start Date for New Records):

-- Insert new records from the staging table into the dimension table with today's date as the start date.
-- The end date is set to '9999-12-31', indicating that it's the latest record.
INSERT INTO product_dim
SELECT *, @today ,'9999-12-31'  
FROM product_stg;


5. Additional Data Insertion into Staging Table:
-- Insert additional data into the staging table for further testing.
INSERT INTO Product_stg Values
(1,'Iphone13', 25000), 
(3, 'Iphone15', 90000),
(1,'Iphone13', 24000),
(4, 'Iphone16', 110000);
