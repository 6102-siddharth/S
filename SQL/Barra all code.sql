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

