create database New_DB;
Use New_DB;

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50)
);

-- Insert 10 Customer Records
INSERT INTO Customer (CustomerID, FirstName, LastName, Email, Phone, City) VALUES
(1, 'John', 'Smith', 'john.smith@email.com', '9876543210', 'New York'),
(2, 'Emma', 'Johnson', 'emma.johnson@email.com', '9876543211', 'Los Angeles'),
(3, 'Michael', 'Brown', 'michael.brown@email.com', '9876543212', 'Chicago'),
(4, 'Olivia', 'Davis', 'olivia.davis@email.com', '9876543213', 'Houston'),
(5, 'William', 'Miller', 'william.miller@email.com', '9876543214', 'Phoenix'),
(6, 'Sophia', 'Wilson', 'sophia.wilson@email.com', '9876543215', 'Philadelphia'),
(7, 'James', 'Moore', 'james.moore@email.com', '9876543216', 'San Antonio'),
(8, 'Ava', 'Taylor', 'ava.taylor@email.com', '9876543217', 'San Diego'),
(9, 'Benjamin', 'Anderson', 'ben.anderson@email.com', '9876543218', 'Dallas'),
(10, 'Mia', 'Thomas', 'mia.thomas@email.com', '9876543219', 'San Jose');

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    ProductName VARCHAR(100),
    Quantity INT,
    Amount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Insert 10 Order Records
INSERT INTO Orders (OrderID, CustomerID, OrderDate, ProductName, Quantity, Amount) VALUES
(101, 1, '2025-01-05', 'Laptop', 1, 750.00),
(102, 2, '2025-01-08', 'Mouse', 2, 40.00),
(103, 3, '2025-01-10', 'Keyboard', 1, 60.00),
(104, 4, '2025-01-12', 'Monitor', 1, 220.00),
(105, 5, '2025-01-15', 'Printer', 1, 180.00),
(106, 6, '2025-01-18', 'Tablet', 2, 500.00),
(107, 7, '2025-01-20', 'Headphones', 3, 150.00),
(108, 8, '2025-01-22', 'Webcam', 1, 90.00),
(109, 9, '2025-01-25', 'Smartphone', 1, 650.00),
(110, 10, '2025-01-28', 'External Hard Drive', 2, 240.00);


select * from customer;
select * from orders;

-- selecting only individual Columns
select customerid, Firstname, lastname from customer;

-- whera clause
select * from customer where city = "New York"; 

select * from customer where city like "Lo%";

-- Order by
select * from customer order by city desc; 

-- Nested Column Query 
select * from customer order by firstname asc,city desc; 

ALTER TABLE Customer
ADD Score INT;

UPDATE Customer SET Score = 85 WHERE CustomerID = 1;
UPDATE Customer SET Score = 92 WHERE CustomerID = 2;
UPDATE Customer SET Score = 78 WHERE CustomerID = 3;
UPDATE Customer SET Score = 88 WHERE CustomerID = 4;
UPDATE Customer SET Score = 95 WHERE CustomerID = 5;
UPDATE Customer SET Score = 81 WHERE CustomerID = 6;
UPDATE Customer SET Score = 74 WHERE CustomerID = 7;
UPDATE Customer SET Score = 90 WHERE CustomerID = 8;
UPDATE Customer SET Score = 87 WHERE CustomerID = 9;
UPDATE Customer SET Score = 93 WHERE CustomerID = 10;

select * from customer;

-- sort the result by city and the highest score
ALTER TABLE Customer;
UPDATE Customer SET city ="Chicago" WHERE CustomerID = 5;

select * from customer order by city , score desc;


-- GRoup by
-- Find the total score for each city
 
select city, sum(score) as Total_scores from customer 
group by city;

-- Find the TOtal score and total number of customers for eact city
select sum(score) as Total_Scores , count(customerid) as Total_Customers , city from customer group by city; 


-- find the total score for each city having score greater than the 90
select sum(score) as Total_Score,city from customer
where Score > 50
group by city
having sum(score) >100;


-- Find the Average score for each country
-- considering onlyt customers with a score not equal to 0

select customerid, firstname , city,
avg(score) as avg_score from customer
where score !=0
group by customerid, firstname, city
having avg_score >90;

-- disinct 
select distinct city from customer;

-- limit clause or TOp 
select * from customer limit 3;

--  Retrive the top 3 customer with the highest score
select * from customer 
order by score 
limit 3;  

--  Retrive the top 2 customer with the lowest score

select * from customer order by score asc
limit 2;

-- Getr the 2 Most Recent Orders

select * from Orders
order by orderdate desc limit 2;

select * from orders;				
select * from customer;			-- Here WE cannot Run Both Queries at one TIme   


-- Here Creating a Static values 
select 123 as Static_Value;

-- we can add our static data to the database

select customerid,firstname, 
"New Customer" as Customer_type
from customer; 


-- DDL Data DEfination Language

-- creating a table called Persons with column Id, person name , birthdate, phone

create table Persons (
Id Int Not null,
FirstName varchar(50) Not Null,
LastName varchar(50) Not Null,
Birth_Date Date,
Phone varchar(15) Not Null,
constraint PK_Persons Primary Key (Id)
)   ;


--  TASk Alter
ALter Table Persons 
Add Email varchar(50) Not Null;
select * from persons;


-- TAsk Drop or Droping a Colunmn
ALter TAble Persons
Drop column Phone ; 
select * from Persons;

-- drop table persons;


-- Inserting Data Into TAble
-- Insert 

select * from customer;
Insert into customer (customerid, Firstname, lastname, Email,phone, City, Score)
Values (11,"Sam","Smueal","sam1234@gmail.com","1234567890","New York",Null),
(12,"Anna","Mul","anna1234@gmail.com","0987654321",Null,80)
;
Insert into customer (customerid, Firstname, lastname, Email,phone, City, Score)
Values (13,"Sami","ssv","smi1234@gmail.com","17774567890","New York",Null);

-- TASk  COpy Data from Customers table into persons
 
  
 select * from Persons;

Insert Into Persons(Id,Firstname, Lastname,Birth_date,phone)
select customerid, firstname, lastname,Null,phone 
from customer;

-- Task Change the SCore of the Customer with Id 6 to 0

select * from customer; 

update customer
Set Score =0
Where customerid =11;

-- TAsk Change the score of customer id 12 to 0 and updae the city to "GB"
select * from Customer; 

Update Customer
set score =0,
	city="GB"
where customerid =12;
select * from customer;

-- TAsk Update all customer with a null score by setting their score to 0

update customer
set Score = 0  
where Score is Null;

select * from customer;

-- Delete 

-- TAsk delete the all customer whose IOd is greater than 5
 
delete from customer
where customerid >10;
select * from customer;

-- TAsk Delete all Data from persons table
select * from persons;
-- delete from persons;  -- It is slower


-- Use Truncate

truncate table persons;
select * from persons; 











