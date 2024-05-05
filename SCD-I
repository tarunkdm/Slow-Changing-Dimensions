# SQL Queries for Slow Changing Dimension Type I Implementation
1. Create Staging and Dimension Tables:

-- Create Staging Table to temporarily hold incoming data.
CREATE TABLE product_stg(
    Product_id  INT,
    Product_Name VARCHAR(50),
    Price   DECIMAL(9,2)
);

-- Create Dimension Table to store historical data with the last update timestamp.
CREATE TABLE product_dim(
    Product_id  INT primary key,
    Product_Name VARCHAR(50),
    Price   DECIMAL(9,2),
    last_update date
);


2. Insert Sample Data into Staging Table:
-- Insert sample data into the staging table for testing and demonstration purposes.
INSERT INTO Product_stg Values
(1,'Iphone13', 30000), 
(2, 'Iphone14', 60000),
(1,'Iphone13', 25000),
(3, 'Iphone15', 90000);

3. Display Contents of Dimension and Staging Tables:
-- View the current contents of the dimension table.
SELECT * FROM product_dim;

-- View the current contents of the staging table.
SELECT * FROM product_stg;


4. Update Dimension Table with Staging Data:

-- Update the dimension table with the latest prices from the staging table.
-- This operation refreshes the price information in the dimension table.
UPDATE product_dim
SET price = product_stg.price
FROM product_stg 
WHERE product_stg.product_id = product_dim.product_id;


5. Display Updated Dimension and Staging Tables:
-- View the dimension table after updating with staging data.
SELECT * FROM product_dim;

-- View the staging table to check if any changes occurred during the update process.
SELECT * FROM product_stg;

6. Insert New Records into Dimension Table from Staging:
-- Declare a variable to store today's date for tracking the last update.
DECLARE @today DATE;
SET @today = CAST(GETDATE() AS DATE);

-- Insert new records from the staging table into the dimension table.
-- This operation adds any new products to the dimension table with the current timestamp.
INSERT INTO product_dim
SELECT *, @today  
FROM product_stg 
WHERE product_id NOT IN (SELECT product_id FROM product_dim);


7. Display Final Contents of Dimension and Staging Tables:
-- View the final contents of the dimension table after all updates.
SELECT * FROM product_dim;

-- View the staging table to ensure it's empty or contains only new incoming data.
SELECT * FROM product_stg;
