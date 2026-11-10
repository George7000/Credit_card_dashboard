-- SQL Query to create and import data from csv files:

-- 0. Create a database 
CREATE DATABASE ccdb;

-- 1. Create cc_detail table

CREATE TABLE cc_detail (
    Client_Num INT,
    Card_Category VARCHAR(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date DATE,
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    current_year INT,
    Credit_Limit DECIMAL(10,2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Ct INT,
    Avg_Utilization_Ratio DECIMAL(10,3),
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10,3),
    Delinquent_Acc VARCHAR(5)
);


-- 2. Create cc_detail table

CREATE TABLE cust_detail (
    Client_Num INT,
    Customer_Age INT,
    Gender VARCHAR(5),
    Dependent_Count INT,
    Education_Level VARCHAR(50),
    Marital_Status VARCHAR(20),
    State_cd VARCHAR(50),
    Zipcode VARCHAR(20),
    Car_Owner VARCHAR(5),
    House_Owner VARCHAR(5),
    Personal_Loan VARCHAR(5),
    Contact VARCHAR(50),
    Customer_Job VARCHAR(50),
    Income INT,
    Cust_Satisfaction_Score INT
);


-- 3. Copy csv data into SQL (remember to update the file name and file location in below query)

-- copy cc_detail table

-- COPY cc_detail
-- FROM 'D:\credit_card.csv' 
-- DELIMITER ',' 
-- CSV HEADER;

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

delete from cc_detail;
SHOW WARNINGS;

LOAD DATA LOCAL INFILE 'C:\\Users\\George\\Credit_Card_Financial_Dashboard-main\\credit_card.csv'
INTO TABLE cc_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Client_Num,Card_Category,Annual_Fees,Activation_30_Days,Customer_Acq_Cost,@Week_Start_Date,Week_Num,Qtr,current_year,Credit_Limit,Total_Revolving_Bal,Total_Trans_Amt,Total_Trans_Ct,Avg_Utilization_Ratio,Use_Chip,Exp_Type,Interest_Earned,Delinquent_Acc)
SET Week_Start_Date = STR_TO_DATE(@Week_Start_Date, '%d-%m-%Y');

LOAD DATA LOCAL INFILE 'C:\\Users\\George\\Credit_Card_Financial_Dashboard-main\\cc_add.csv'
INTO TABLE cc_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Client_Num,Card_Category,Annual_Fees,Activation_30_Days,Customer_Acq_Cost,@Week_Start_Date,Week_Num,Qtr,current_year,Credit_Limit,Total_Revolving_Bal,Total_Trans_Amt,Total_Trans_Ct,Avg_Utilization_Ratio,Use_Chip,Exp_Type,Interest_Earned,Delinquent_Acc)
SET Week_Start_Date = STR_TO_DATE(@Week_Start_Date, '%d-%m-%Y');


DESCRIBE cc_detail;

SELECT * from cc_detail;

-- copy cust_detail table

-- COPY cust_detail
-- FROM 'D:\customer.csv' 
-- DELIMITER ',' 
-- CSV HEADER;
LOAD DATA LOCAL INFILE 'C:\\Users\\George\\Credit_Card_Financial_Dashboard-main\\customer.csv'
INTO TABLE cust_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
select * from cust_detail;

LOAD DATA LOCAL INFILE 'C:\\Users\\George\\Credit_Card_Financial_Dashboard-main\\cust_add.csv'
INTO TABLE cust_detail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
select * from cust_detail;



select count(*) from cc_detail;
select count(*) from cust_detail;
-- If you are getting below error, then use the below point:  
   -- ERROR:  date/time field value out of range: "0"
   -- HINT:  Perhaps you need a different "datestyle" setting.

-- Check the Data in Your CSV File: Ensure date column values are formatted correctly and are in a valid format that PostgreSQL can recognize (e.g., YYYY-MM-DD). And correct any incorrect or missing date values in the CSV file. 
   -- or
-- Update the Datestyle Setting: Set the datestyle explicitly for your session using the following command:
-- SET datestyle TO 'ISO, DMY';


-- Now, try to COPY the csv files!


-- 4. Insert additional data into SQL, using same COPY function

-- copy additional data (week-53) in cc_detail table

COPY cc_detail
FROM 'D:\cc_add.csv' 
DELIMITER ',' 
CSV HEADER;


-- copy additional data (week-53) in cust_detail table (remember to update the file name and file location in below query)

COPY cust_detail
FROM 'D:\cust_add.csv' 
DELIMITER ',' 
CSV HEADER;

