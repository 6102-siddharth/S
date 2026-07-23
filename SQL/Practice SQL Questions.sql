-- ==========================================
-- DATABASE Datasetsa & questions
-- ==========================================

DROP DATABASE IF EXISTS company_db;
CREATE DATABASE company_db;
USE company_db;

-- ==========================================
-- DEPARTMENTS
-- ==========================================

CREATE TABLE departments(
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL UNIQUE,
    location VARCHAR(50)
);

INSERT INTO departments(department_name,location) VALUES
('HR','New York'),
('IT','California'),
('Finance','Chicago'),
('Marketing','Texas'),
('Sales','Florida'),
('Admin','Boston');

-- ==========================================
-- JOBS
-- ==========================================

CREATE TABLE jobs(
    job_id INT PRIMARY KEY AUTO_INCREMENT,
    job_title VARCHAR(50),
    min_salary DECIMAL(10,2),
    max_salary DECIMAL(10,2)
);

INSERT INTO jobs(job_title,min_salary,max_salary) VALUES
('Manager',70000,150000),
('Developer',40000,120000),
('Tester',35000,90000),
('HR Executive',30000,70000),
('Sales Executive',30000,90000),
('Accountant',35000,85000);

-- ==========================================
-- EMPLOYEES
-- ==========================================

CREATE TABLE employees(
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender CHAR(1),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    hire_date DATE,
    salary DECIMAL(10,2),
    bonus DECIMAL(10,2) DEFAULT 0,
    commission DECIMAL(10,2),
    manager_id INT,
    department_id INT,
    job_id INT,
    status VARCHAR(20) DEFAULT 'Active',

    FOREIGN KEY(manager_id) REFERENCES employees(employee_id),
    FOREIGN KEY(department_id) REFERENCES departments(department_id),
    FOREIGN KEY(job_id) REFERENCES jobs(job_id)
);

INSERT INTO employees
(first_name,last_name,gender,email,phone,hire_date,salary,bonus,commission,manager_id,department_id,job_id)
VALUES

('John','Smith','M','john@gmail.com','1111111111','2020-01-10',90000,10000,5000,NULL,2,1),

('David','Wilson','M','david@gmail.com','2222222222','2021-02-20',70000,5000,2000,1,2,2),

('Emma','Brown','F','emma@gmail.com','3333333333','2019-05-14',75000,8000,NULL,1,3,6),

('Sophia','Miller','F','sophia@gmail.com','4444444444','2022-03-21',50000,2000,1000,2,2,2),

('James','Taylor','M','james@gmail.com','5555555555','2018-08-18',120000,15000,7000,NULL,2,1),

('Olivia','Johnson','F','olivia@gmail.com','6666666666','2023-01-05',45000,1500,NULL,5,4,4),

('Daniel','Lee','M','daniel@gmail.com','7777777777','2022-09-11',55000,2500,1200,5,5,5),

('Ava','Martin','F','ava@gmail.com','8888888888','2020-07-09',65000,3500,NULL,1,3,6),

('Michael','White','M','michael@gmail.com','9999999999','2021-04-12',48000,2000,500,2,5,5),

('Charlotte','King','F','charlotte@gmail.com','1010101010','2019-11-30',60000,4000,NULL,5,6,4),

('William','Hall','M','william@gmail.com','1212121212','2022-12-15',70000,5000,2000,1,2,2),

('Mia','Young','F','mia@gmail.com','1313131313','2024-02-11',42000,1000,NULL,2,4,4);

-- ==========================================
-- CUSTOMERS
-- ==========================================

CREATE TABLE customers(
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100)
);

INSERT INTO customers(customer_name,city,country,phone,email) VALUES
('ABC Pvt Ltd','New York','USA','111','abc@gmail.com'),
('XYZ Ltd','Chicago','USA','222','xyz@gmail.com'),
('Global Tech','London','UK','333','global@gmail.com'),
('Prime Retail','Toronto','Canada','444','prime@gmail.com'),
('Vision Corp','Sydney','Australia','555','vision@gmail.com');

-- ==========================================
-- PRODUCTS
-- ==========================================

CREATE TABLE products(
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

INSERT INTO products(product_name,category,price,stock) VALUES
('Laptop','Electronics',65000,50),
('Mouse','Electronics',700,250),
('Keyboard','Electronics',1200,150),
('Monitor','Electronics',15000,40),
('Printer','Electronics',11000,20),
('Chair','Furniture',5000,80),
('Table','Furniture',8000,35);

-- ==========================================
-- ORDERS
-- ==========================================

CREATE TABLE orders(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    employee_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),

    FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY(employee_id) REFERENCES employees(employee_id)
);

INSERT INTO orders(customer_id,employee_id,order_date,total_amount) VALUES
(1,7,'2024-01-10',65700),
(2,4,'2024-01-12',15000),
(3,9,'2024-02-01',72000),
(1,7,'2024-03-14',8200),
(5,10,'2024-03-25',16000),
(4,9,'2024-04-11',9000);

-- ==========================================
-- ORDER DETAILS
-- ==========================================

CREATE TABLE order_details(
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),

    FOREIGN KEY(order_id) REFERENCES orders(order_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id)
);

INSERT INTO order_details(order_id,product_id,quantity,unit_price) VALUES
(1,1,1,65000),
(1,2,1,700),
(2,4,1,15000),
(3,1,1,65000),
(3,3,2,1200),
(3,2,5,700),
(4,7,1,8000),
(5,5,1,11000),
(5,6,1,5000),
(6,6,1,5000),
(6,3,2,1200);

-- ==========================================
-- PAYMENTS
-- ==========================================

CREATE TABLE payments(
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(30),
    amount DECIMAL(10,2),

    FOREIGN KEY(order_id) REFERENCES orders(order_id)
);

INSERT INTO payments(order_id,payment_date,payment_method,amount) VALUES
(1,'2024-01-10','Credit Card',65700),
(2,'2024-01-12','Cash',15000),
(3,'2024-02-02','UPI',72000),
(4,'2024-03-15','Credit Card',8200),
(5,'2024-03-25','UPI',16000),
(6,'2024-04-12','Cash',9000);



select * from customers;
select * from departments;
select * from employees;
select * from jobs;
select * from order_details;
select * from orders;
select * from payments;
select * from products;


-- MYSQL Practice Questions (Basics to Advanced)

-- 1. SELECT Statement (20 Questions)

-- 1. Display all employees.
select * from employees;

-- 2. Display only first_name and salary.
select first_name, salary from employees;

-- 3. Display all departments.
select * from departments;

-- 4. Display all products.
select * from products;

-- 5. Display all customers.
select * from customers;

-- 6. Display employee names with email.
select concat(first_name, last_name) as Emp_Name, email from employees;

-- 7. Display product name and price.
select product_name , price from products;

-- 8. Display job titles.
select job_title from jobs;

-- 9. Display orders.
select * from orders;

-- 10. Display payment details.
select * from payments;

-- 11. Display unique department IDs from employees.
select distinct department_id from employees;

-- 12. Display unique cities from customers.
select distinct city from customers;

-- 13. Display employee names with salaries.
select concat(first_name,last_name) as EMP_name , salary from employees;

-- 14. Display all employee emails.
select  email from employees;

-- 15. Display all product categories.
select Product_id, Category from products;

-- 16. Display employee names and hire dates.
select concat(first_name, last_name) as EMP_name , hire_date 
from employees ;


-- 17. Display customer names and countries.
select customer_name, country from customers;

-- 18. Display all managers.
select manager_id from employees;

-- 19. Display order amounts.
select sum(Total_amount) as Total_Amounts from orders;

-- 20. Display employee IDs in ascending order.
select employee_id from employees order by employee_id asc;



select * from customers;
select * from departments;
select * from employees;
select * from jobs;
select * from order_details;
select * from orders;
select * from payments;
select * from products;

-- 2. WHERE Clause (20 Questions)

-- 1. Employees with salary greater than 50000.
select * from employees where salary > 50000;

-- 2. Employees with salary less than 70000.
select * from employees where salary < 70000;

-- 3. Employees in department 2.
select * from employees where department_id = 2;

-- 4. Female employees.
select * from employees where gender = "F";

-- 5. Male employees.
select * from employees where Gender = "M";

-- 6. Products costing more than 10000.
select * from products where price > 10000;

-- 7. Products with stock less than 50.
select * from products where stock < 50;


-- 8. Customers from USA.
select * from customers where country ="USA";

-- 9. Employees hired after 2022.
select * from employees where hire_date > "2022-01-01";

-- 10. Employees hired before 2021.
select * from employees where hire_date <"2021-01-01";

-- 11. Orders above 20000.
select * from orders where total_amount > 20000;

-- 12. Orders below 10000.
select * from orders where total_amount < 10000;

-- 13. Employees whose bonus is greater than 3000.
select * from employees where bonus > 3000;

-- 14. Employees with NULL commission.
select * from employees where commission is Null;

-- 15. Employees whose commission is NOT NULL.
select * from employees where commission is not Null;

-- 16. Customers from Canada.
select * from customers where country = "Canada";

-- 17. Employees with salary equal to 70000.
select * from employees where salary = 70000;

-- 18. Products in Furniture category.
select * from products where category = "Furniture";

-- 19. Employees with status Active.
select * from employees where status = "active";

-- 20. Payments made by Cash.
select * from payments where payment_Method = "Cash";




select * from customers;
select * from departments;
select * from employees;
select * from jobs;
select * from order_details;
select * from orders;
select * from payments;
select * from products;


-- 3. Comparison Operators (=, <>, >, <, >=, <=) (20 Questions)

-- 1. Salary = 70000
select * from employees where salary = 70000;

-- 2. Salary <> 70000
select * from employees where salary <> 70000;

-- 3. Salary > 60000
select * from employees where salary > 60000;

-- 4. Salary < 60000
select * from employees where salary < 60000;

-- 5. Salary >= 50000
select * from employees where salary >= 50000;

-- 6. Salary <= 50000
select * from employees where salary <= 50000;

-- 7. Stock >100
select * from products where stock > 100;

-- 8. Stock <50
select * from products where stock < 50;

-- 9. Orders >=15000
select *,(unit_price * quantity)  as orders  from order_details where (unit_price * quantity) >= 15000;

-- 10. Orders <=9000
select *, (unit_price * quantity) as orders from order_details  where (unit_price * quantity) <= 9000;

-- 11. Price=65000
select * from order_details where unit_price = 65000;

-- 12. Price<>700
select * from order_details where unit_price <> 700; 

-- 13. Department=IT
select * from departments where department_name = "IT";

-- 14. Customer country=UK
select * from customers where country = "UK";

-- 15. Employee ID>5
select * from employees where Employee_ID >5;

-- 16. Employee ID<10
select * from employees where EMployee_id >10;

-- 17. Bonus>=5000
select * from employees where bonus >=5000;

-- 18. Commission<=1000
select * from employees where commission <= 1000;

-- 19. Hire date>2022
select * from employees where Hire_date > "2023-01-01";

-- 20. Hire date<2021
select *from employees where hire_date < "2022-01-01";


select * from customers;
select * from departments;
select * from employees;
select * from jobs;
select * from order_details;
select * from orders;
select * from payments;
select * from products;


-- 4. Logical Operators (AND OR NOT) (20 Questions)

-- 1. Salary >50000 AND department=2
select * from employees where salary > 50000 AND department_id =2;

-- 2. Salary >50000 OR department=3
select * from employees where salary > 50000 OR department_id =3;

-- 3. NOT department=2
select * from departments where department_id !=2;

select * from employees where department_id !=2;

-- 4. Female AND salary>60000
select * from employees where gender ="F" AND Salary > 60000;

-- 5. Male OR salary<50000
select * from employees where gender ="M" AND Salary < 50000;

-- 6. Product price>10000 AND stock<50
select * from products where price > 10000 ANd Stock < 50;

-- 7. Customer from USA AND city=Chicago
select * from customers where country = "USA" AND City ="Chicago";

-- 8. Orders >10000 AND employee=7
select * from orders where Total_amount > 10000 AND Employee_id =7;

-- 9. Bonus>2000 OR commission>1000
select * from employees where Bonus >2000 Or Commission >1000;

-- 10. NOT country='USA'
select * from customers where Country != "USA";

-- 11. Salary>50000 AND hire_date>'2021-01-01'
select * from employees where salary > 50000 AND Hire_date > '2021-01-01';

-- 12. Price<10000 OR category='Furniture'
select * from products where price < 10000 Or category = "Furniture";

-- 13. Department=2 AND job=2
select * from employees where Department_id =2 AND Job_Id = 2;

-- 14. Department=2 OR job=1
select * from employees where Department_id =2 Or Job_Id = 1;

-- 15. Bonus>3000 AND commission IS NULL
select * from employees where Bonus > 3000 ANd Commission is null;

-- 16. Stock>30 AND price<10000
select * from products where stock > 30 AND Price < 10000;

-- 17. Customer city='London' OR country='Canada'
select * from customers where city = "London" Or COuntry = "Canada";

-- 18. Hire_date<'2022' AND salary>60000
select * from employees where Hire_date < "2022-12-31" ANd salary >60000;

-- 19. Payment='Cash' AND amount>10000
select * from payments where payment_method ="cash" AND Amount  >10000;

-- 20. Payment='UPI' OR amount<10000
select *from payments where payment_method ="UPI" Or Amount <10000;


-- 5. LIKE Operator (20 Questions)

-- 1. First name starts with J.
select * from employees where First_name like "J%";

-- 2. Last name starts with M.
select * from employees where Last_name  like "M%"; 

-- 3. Email contains gmail.
select * from employees where email like "%gmail%";

-- 4. Customer names ending with Ltd.
select * from customers where customer_name like "%Ltd";

-- 5. Product names containing 'o'.
select * from products where Product_name like "%o%";

-- 6. Employee names ending with 'a'.
select * from employees where first_name like "%a";

-- 7. Department names starting with M.
select * from departments where department_name like "M%";

-- 8. Job title containing 'Manager'.
select * from jobs where Job_TItle = "Manager";

-- 9. Product names ending with r.
select * from products where product_name like "%r";

-- 10. Country starts with U.
select * from customers where COuntry like "U%";

-- 11. Employee first name second letter='a'.
select * from employees where first_name like "_a%";

-- 12. Employee name contains 'li'.
select * from employees where first_name like "%li%";

-- 13. Customer email ends with .com
select * from customers where email like "%.com";

-- 14. Product contains 'top'
select * from products where product_name like "%top%";

-- 15. Job title ends with Executive
select * from jobs where job_title like "%Executive%";

-- 16. City starts with T
select * from customers where city like "T%";

-- 17. Phone begins with 1
select * from employees where phone like "1%";

-- 18. First name has exactly 4 letters
select * from employees where char_length(first_name) = 4;

-- 19. Last name has exactly 5 letters
select * from employees where char_length(last_name)=5;

-- 20. Product category starts with E
select * from products where category  like  "E%"




















-- MySQL Question Bank (0 → Advanced)

-- Level 1: Introduction to Databases

-- 1. What is a database?
-- 2. What is DBMS?
-- 3. What is RDBMS?
-- 4. What is MySQL?
-- 5. What are the features of MySQL?
-- 6. What are the advantages of MySQL?
-- 7. What is SQL?
-- 8. What are the types of SQL commands?
-- 9. Explain DDL, DML, DCL, TCL, and DQL.
-- 10. Difference between DBMS and RDBMS.

-- Level 2: Installing & Connecting

-- 11. How do you install MySQL?
-- 12. How do you connect to MySQL Server?
-- 13. How do you log in using the command line?
-- 14. What is MySQL Workbench?
-- 15. Difference between MySQL Server and MySQL Workbench.
-- 16. How do you check the MySQL version?
-- 17. How do you create a database?
-- 18. How do you delete a database?
-- 19. How do you rename a database?
-- 20. How do you view all databases?

-- Level 3: Tables

-- 21. Create a table.
-- 22. Show table structure.
-- 23. Describe a table.
-- 24. Rename a table.
-- 25. Drop a table.
-- 26. Truncate a table.
-- 27. Difference between DROP, DELETE and TRUNCATE.
-- 28. Add a column.
-- 29. Modify a column.
-- 30. Drop a column.
-- 31. Rename a column.
-- 32. Change column datatype.



-- Level 4: Data Types

-- 33. What are numeric data types?
-- 34. Difference between INT and BIGINT.
-- 35. CHAR vs VARCHAR.
-- 36. TEXT vs VARCHAR.
-- 37. DATE vs DATETIME.
-- 38. TIMESTAMP vs DATETIME.
-- 39. DECIMAL vs FLOAT.
-- 40. ENUM datatype.
-- 41. BOOLEAN datatype.
-- 42. BLOB datatype.



-- Level 5: CRUD Operations

-- 43. Insert one row.
-- 44. Insert multiple rows.
-- 45. Copy data from another table.
-- 46. Update one row.
-- 47. Update multiple rows.
-- 48. Delete one row.
-- 49. Delete multiple rows.
-- 50. Delete all records.
-- 51. Select all records.
-- 52. Select specific columns.



-- Level 6: WHERE Clause

-- 53. Use WHERE clause.
-- 54. Use AND operator.
-- 55. Use OR operator.
-- 56. Use NOT operator.
-- 57. Use BETWEEN.
-- 58. Use IN.
-- 59. Use NOT IN.
-- 60. Use LIKE.
-- 61. Difference between % and _.
-- 62. Use IS NULL.
-- 63. Use IS NOT NULL.



-- Level 7: Sorting & Limiting

-- 64. ORDER BY ASC
-- 65. ORDER BY DESC
-- 66. LIMIT
-- 67. OFFSET
-- 68. Top 5 highest salaries.
-- 69. Second highest salary.
-- 70. Third highest salary.
-- 71. Last inserted record.
-- 72. First inserted record.



-- Level 8: Aggregate Functions

-- 73. COUNT()
-- 74. SUM()
-- 75. AVG()
-- 76. MAX()
-- 77. MIN()
-- 78. ROUND()
-- 79. CEIL()
-- 80. FLOOR()
-- 81. ABS()
-- 82. MOD()



-- Level 9: GROUP BY & HAVING

-- 83. GROUP BY department.
-- 84. HAVING clause.
-- 85. GROUP BY multiple columns.
-- 86. Count employees department-wise.
-- 87. Highest salary department-wise.
-- 88. Lowest salary department-wise.
-- 89. Average salary department-wise.
-- 90. Departments having more than 10 employees.



-- Level 10: String Functions

-- 91. CONCAT()
-- 92. LENGTH()
-- 93. CHAR_LENGTH()
-- 94. UPPER()
-- 95. LOWER()
-- 96. SUBSTRING()
-- 97. REPLACE()
-- 98. TRIM()
-- 99. LEFT()
-- 100. RIGHT()
-- 101. REVERSE()
-- 102. LOCATE()
-- 103. INSTR()
-- 104. LPAD()
-- 105. RPAD()



-- Level 11: Date Functions

-- 106. CURDATE()
-- 107. NOW()
-- 108. CURRENT_TIMESTAMP
-- 109. YEAR()
-- 110. MONTH()
-- 111. DAY()
-- 112. DATEDIFF()
-- 113. DATE_ADD()
-- 114. DATE_SUB()
-- 115. LAST_DAY()
-- 116. EXTRACT()
-- 117. TIMESTAMPDIFF()



-- Level 12: Mathematical Functions

-- 118. POWER()
-- 119. SQRT()
-- 120. RAND()
-- 121. PI()
-- 122. EXP()
-- 123. LOG()
-- 124. SIN()
-- 125. COS()
-- 126. TAN()



-- Level 13: Constraints

-- 127. PRIMARY KEY
-- 128. FOREIGN KEY
-- 129. UNIQUE
-- 130. CHECK
-- 131. DEFAULT
-- 132. NOT NULL
-- 133. AUTO_INCREMENT
-- 134. Composite Primary Key
-- 135. Composite Foreign Key
-- 136. Difference between PRIMARY KEY and UNIQUE.



-- Level 14: Keys

-- 137. Candidate Key
-- 138. Alternate Key
-- 139. Super Key
-- 140. Composite Key
-- 141. Foreign Key
-- 142. Surrogate Key
-- 143. Natural Key



-- Level 15: Joins

-- 144. INNER JOIN
-- 145. LEFT JOIN
-- 146. RIGHT JOIN
-- 147. CROSS JOIN
-- 148. SELF JOIN
-- 149. Difference between INNER and LEFT JOIN.
-- 150. Multiple table joins.
-- 151. Employee-Department Join.
-- 152. Student-Course Join.
-- 153. Customer-Order Join.



-- Level 16: Subqueries

-- 154. Single-row subquery.
-- 155. Multi-row subquery.
-- 156. Correlated subquery.
-- 157. Nested subquery.
-- 158. EXISTS
-- 159. NOT EXISTS
-- 160. ANY
-- 161. ALL
-- 162. IN with subquery.



-- Level 17: Set Operators

-- 163. UNION
-- 164. UNION ALL
-- 165. Difference between UNION and UNION ALL.



-- Level 18: Views

-- 166. Create View.
-- 167. Update View.
-- 168. Drop View.
-- 169. Advantages of Views.
-- 170. Updatable Views.



-- Level 19: Indexes

-- 171. Create Index.
-- 172. Unique Index.
-- 173. Composite Index.
-- 174. Drop Index.
-- 175. Clustered vs Non-clustered Index.
-- 176. Explain EXPLAIN command.
-- 177. How indexes improve performance?



-- Level 20: Stored Procedures

-- 178. Create Procedure.
-- 179. Procedure with parameters.
-- 180. Call Procedure.
-- 181. Drop Procedure.
-- 182. IN parameter.
-- 183. OUT parameter.
-- 184. INOUT parameter.



-- Level 21: Functions

-- 185. Create Function.
-- 186. Function with parameters.
-- 187. Return value.
-- 188. Drop Function.



-- Level 22: Triggers

-- 189. BEFORE INSERT
-- 190. AFTER INSERT
-- 191. BEFORE UPDATE
-- 192. AFTER UPDATE
-- 193. BEFORE DELETE
-- 194. AFTER DELETE



-- Level 23: Transactions

-- 195. START TRANSACTION
-- 196. COMMIT
-- 197. ROLLBACK
-- 198. SAVEPOINT
-- 199. RELEASE SAVEPOINT
-- 200. ACID Properties.



-- Level 24: Normalization

-- 201. 1NF
-- 202. 2NF
-- 203. 3NF
-- 204. BCNF
-- 205. 4NF
-- 206. 5NF
-- 207. Denormalization.
-- 208. Advantages of Normalization.



-- Level 25: Advanced Queries

-- 209. Find duplicate records.
-- 210. Delete duplicate records.
-- 211. Find nth highest salary.
-- 212. Find employees earning above average salary.
-- 213. Running total.
-- 214. Rank employees.
-- 215. Dense Rank.
-- 216. Row Number.
-- 217. Common Table Expressions (CTEs).
-- 218. Recursive CTE.
-- 219. Window Functions.
-- 220. LEAD()
-- 221. LAG()
-- 222. FIRST_VALUE()
-- 223. LAST_VALUE()
-- 224. NTILE()



-- Level 26: Performance Optimization

-- 225. What is query optimization?
-- 226. How does EXPLAIN work?
-- 227. Slow Query Log.
-- 228. Index optimization.
-- 229. Covering Index.
-- 230. Composite Index.
-- 231. Partitioning.
-- 232. Query Cache.
-- 233. Optimize JOIN performance.
-- 234. Optimize GROUP BY.
-- 235. Optimize ORDER BY.



-- Level 27: Security

-- 236. Create User.
-- 237. Drop User.
-- 238. Change Password.
-- 239. GRANT privileges.
-- 240. REVOKE privileges.
-- 241. Roles in MySQL.
-- 242. Backup Database.
-- 243. Restore Database.



-- Level 28: Import & Export

-- 244. Import CSV.
-- 245. Export CSV.
-- 246. Import SQL file.
-- 247. Export SQL file.
-- 248. mysqldump.
-- 249. mysqlimport.



-- Level 29: Real Interview Questions

-- 250. Difference between DELETE, DROP and TRUNCATE.
-- 251. Difference between CHAR and VARCHAR.
-- 252. Difference between PRIMARY KEY and UNIQUE.
-- 253. Difference between WHERE and HAVING.
-- 254. Difference between UNION and UNION ALL.
-- 255. Difference between JOIN and SUBQUERY.
-- 256. Difference between Clustered and Non-Clustered Index.
-- 257. Explain ACID.
-- 258. Explain Normalization.
-- 259. Explain Indexing.
-- 260. What is a Deadlock?
-- 261. What are Window Functions?
-- 262. What is a CTE?
-- 263. What is a Trigger?
-- 264. What is a Stored Procedure?
-- 265. What is a Cursor?
-- 266. What is a View?
-- 267. Explain Transactions.
-- 268. What is Referential Integrity?
-- 269. Explain Query Optimization.
-- 270. How do you improve SQL performance?

-- Level 30: Hands-on Practice Projects

-- 271. Design a Student Management Database.
-- 272. Design a Hospital Management System.
-- 273. Design a Banking System.
-- 274. Design an E-commerce Database.
-- 275. Design a Library Management System.
-- 276. Design an Inventory Management System.
-- 277. Design an Employee Payroll System.
-- 278. Design a Hotel Booking System.
-- 279. Design a Food Delivery Database.
-- 280. Design a Social Media Database.


-- MySQL Interview Questions (Basic → Advanced)

-- Level 1: SQL & Database Fundamentals (1–25)

-- 1. What is a database?
-- 2. What is DBMS?
-- 3. What is RDBMS?
-- 4. What is SQL?
-- 5. What are the different types of SQL commands?
-- 6. What are DDL, DML, DCL, TCL, and DQL?
-- 7. What is MySQL?
-- 8. What are the advantages of MySQL?
-- 9. Difference between MySQL and SQL.
-- 10. Difference between MySQL and SQL Server.
-- 11. What is a table?
-- 12. What is a row?
-- 13. What is a column?
-- 14. What is a schema?
-- 15. What is a database instance?
-- 16. What is metadata?
-- 17. What are constraints?
-- 18. What is a primary key?
-- 19. What is a foreign key?
-- 20. What is referential integrity?
-- 21. What is NULL?
-- 22. Difference between NULL and 0.
-- 23. Difference between DELETE, DROP, and TRUNCATE.
-- 24. Difference between CHAR and VARCHAR.
-- 25. Difference between INT and BIGINT.



-- Level 2: CRUD Operations (26–45)

-- 26. Write a query to create a table.
-- 27. Insert a single record.
-- 28. Insert multiple records.
-- 29. Update a record.
-- 30. Delete a record.
-- 31. Display all records.
-- 32. Display specific columns.
-- 33. Use WHERE clause.
-- 34. Difference between WHERE and HAVING.
-- 35. Use ORDER BY.
-- 36. Use LIMIT.
-- 37. Use DISTINCT.
-- 38. Use LIKE.
-- 39. Difference between % and _.
-- 40. Use BETWEEN.
-- 41. Use IN.
-- 42. Use NOT IN.
-- 43. Use IS NULL.
-- 44. Use IS NOT NULL.
-- 45. Explain SQL execution order.



-- Level 3: Constraints (46–60)

-- 46. Explain NOT NULL.
-- 47. Explain UNIQUE.
-- 48. Explain PRIMARY KEY.
-- 49. Explain FOREIGN KEY.
-- 50. Explain CHECK.
-- 51. Explain DEFAULT.
-- 52. Explain AUTO_INCREMENT.
-- 53. Difference between PRIMARY KEY and UNIQUE.
-- 54. Can a table have multiple PRIMARY KEYs?
-- 55. Can a table have multiple UNIQUE constraints?
-- 56. Can a FOREIGN KEY contain NULL values?
-- 57. What happens if a parent record is deleted?
-- 58. What is CASCADE?
-- 59. What is SET NULL?
-- 60. What is RESTRICT?



-- Level 4: Functions (61–90)

-- 61. What are aggregate functions?
-- 62. Difference between COUNT(*) and COUNT(column).
-- 63. Difference between COUNT() and SUM().
-- 64. Explain AVG().
-- 65. Explain MAX().
-- 66. Explain MIN().
-- 67. Explain CONCAT().
-- 68. Explain SUBSTRING().
-- 69. Explain LENGTH().
-- 70. Explain CHAR_LENGTH().
-- 71. Explain REPLACE().
-- 72. Explain TRIM().
-- 73. Explain UPPER().
-- 74. Explain LOWER().
-- 75. Explain ROUND().
-- 76. Explain CEIL().
-- 77. Explain FLOOR().
-- 78. Explain MOD().
-- 79. Explain ABS().
-- 80. Explain CURDATE().
-- 81. Explain NOW().
-- 82. Explain DATE_ADD().
-- 83. Explain DATE_SUB().
-- 84. Explain DATEDIFF().
-- 85. Explain YEAR().
-- 86. Explain MONTH().
-- 87. Explain DAY().
-- 88. Explain EXTRACT().
-- 89. Explain IF().
-- 90. Explain CASE.



-- Level 5: GROUP BY & HAVING (91–105)

-- 91. Explain GROUP BY.
-- 92. Explain HAVING.
-- 93. Difference between WHERE and HAVING.
-- 94. Find department-wise employee count.
-- 95. Find average salary by department.
-- 96. Find highest salary department-wise.
-- 97. Find lowest salary department-wise.
-- 98. Find departments having more than five employees.
-- 99. Find total salary department-wise.
-- 100. Find city-wise customer count.
-- 101. Find monthly sales.
-- 102. Find yearly sales.
-- 103. Find product-wise revenue.
-- 104. Find duplicate records.
-- 105. Delete duplicate records.



-- Level 6: Joins (106–140)

-- 106. What is a JOIN?
-- 107. Types of JOINs.
-- 108. Explain INNER JOIN.
-- 109. Explain LEFT JOIN.
-- 110. Explain RIGHT JOIN.
-- 111. Explain CROSS JOIN.
-- 112. Explain SELF JOIN.
-- 113. Difference between INNER and LEFT JOIN.
-- 114. Difference between LEFT and RIGHT JOIN.
-- 115. Difference between JOIN and UNION.
-- 116. Employee–Department JOIN.
-- 117. Customer–Order JOIN.
-- 118. Student–Course JOIN.
-- 119. Write a query using three tables.
-- 120. Join four tables.
-- 121. Find employees without departments.
-- 122. Find customers with no orders.
-- 123. Find products never sold.
-- 124. Find managers and employees.
-- 125. Explain Cartesian Product.
-- 126. Explain Natural Join.
-- 127. Explain Equi Join.
-- 128. Explain Non-Equi Join.
-- 129. Explain Self Join with example.
-- 130. Explain Multiple Join.
-- 131. Explain Join optimization.
-- 132. Explain Join order.
-- 133. Which JOIN is faster?
-- 134. Why are indexes important in JOINs?
-- 135. How does MySQL execute JOINs?
-- 136. Explain Nested Loop Join.
-- 137. Explain Hash Join (conceptually).
-- 138. Explain Merge Join (conceptually).
-- 139. Explain Join buffering.
-- 140. Common JOIN mistakes.



-- Level 7: Subqueries (141–160)

-- 141. What is a subquery?
-- 142. Types of subqueries.
-- 143. Correlated subquery.
-- 144. Nested subquery.
-- 145. EXISTS.
-- 146. NOT EXISTS.
-- 147. ANY.
-- 148. ALL.
-- 149. IN.
-- 150. Scalar subquery.
-- 151. Find employees earning above average salary.
-- 152. Find second highest salary.
-- 153. Find third highest salary.
-- 154. Find nth highest salary.
-- 155. Find duplicate emails.
-- 156. Find latest order.
-- 157. Find oldest order.
-- 158. Find customers who never ordered.
-- 159. Find products above average price.
-- 160. Compare JOIN vs Subquery.



-- Level 8: Views, Indexes & Transactions (161–185)

-- 161. What is a View?
-- 162. Advantages of Views.
-- 163. Materialized View (concept).
-- 164. What is an Index?
-- 165. Types of Indexes.
-- 166. Clustered vs Non-clustered Index (concept).
-- 167. Composite Index.
-- 168. Unique Index.
-- 169. Covering Index.
-- 170. Explain EXPLAIN.
-- 171. Explain Transactions.
-- 172. ACID properties.
-- 173. COMMIT.
-- 174. ROLLBACK.
-- 175. SAVEPOINT.
-- 176. Isolation Levels.
-- 177. Dirty Read.
-- 178. Non-repeatable Read.
-- 179. Phantom Read.
-- 180. Deadlock.
-- 181. Locking.
-- 182. Optimistic Locking.
-- 183. Pessimistic Locking.
-- 184. Auto Commit.
-- 185. Transaction Log.



-- Level 9: Stored Procedures, Functions & Triggers (186–205)

-- 186. What is a Stored Procedure?
-- 187. Advantages of Stored Procedures.
-- 188. Procedure vs Function.
-- 189. Create Procedure.
-- 190. Create Function.
-- 191. IN Parameter.
-- 192. OUT Parameter.
-- 193. INOUT Parameter.
-- 194. What is a Trigger?
-- 195. BEFORE Trigger.
-- 196. AFTER Trigger.
-- 197. Trigger use cases.
-- 198. Trigger limitations.
-- 199. Event Scheduler.
-- 200. Cursors.
-- 201. Cursor advantages.
-- 202. Cursor disadvantages.
-- 203. Exception handling.
-- 204. SIGNAL statement.
-- 205. DECLARE HANDLER.



-- Level 10: Database Design (206–225)

-- 206. What is normalization?
-- 207. Explain 1NF.
-- 208. Explain 2NF.
-- 209. Explain 3NF.
-- 210. Explain BCNF.
-- 211. Explain 4NF.
-- 212. Explain 5NF.
-- 213. What is denormalization?
-- 214. Candidate Key.
-- 215. Alternate Key.
-- 216. Composite Key.
-- 217. Super Key.
-- 218. Surrogate Key.
-- 219. Natural Key.
-- 220. Star Schema.
-- 221. Snowflake Schema.
-- 222. OLTP vs OLAP.
-- 223. Data Warehouse.
-- 224. ER Diagram.
-- 225. Database design interview question.



-- Level 11: Performance & Optimization (226–250)

-- 226. Why is a query slow?
-- 227. How do you optimize a slow query?
-- 228. Explain EXPLAIN plan.
-- 229. Slow Query Log.
-- 230. Query Cache (historical concept).
-- 231. How do indexes improve performance?
-- 232. When should indexes not be used?
-- 233. Composite Index optimization.
-- 234. Covering Index.
-- 235. Why is SELECT * discouraged?
-- 236. Difference between EXISTS and IN.
-- 237. UNION vs UNION ALL.
-- 238. How do you optimize JOINs?
-- 239. How do you optimize GROUP BY?
-- 240. How do you optimize ORDER BY?
-- 241. Partitioning.
-- 242. Sharding (concept).
-- 243. Replication.
-- 244. Backup strategies.
-- 245. Restore strategies.
-- 246. High Availability.
-- 247. Explain InnoDB.
-- 248. Explain MyISAM.
-- 249. InnoDB vs MyISAM.
-- 250. How would you troubleshoot a production database issue?



-- Level 12: Coding & Scenario-Based Questions (251–300)

-- 251. Find the second highest salary.
-- 252. Find the third highest salary.
-- 253. Find the nth highest salary.
-- 254. Find duplicate rows.
-- 255. Delete duplicate rows.
-- 256. Find employees with no manager.
-- 257. Find managers with more than five employees.
-- 258. Find customers who never placed an order.
-- 259. Find products never sold.
-- 260. Find the top 5 highest-paid employees.
-- 261. Find the lowest salary in each department.
-- 262. Find employees earning above their department average.
-- 263. Find the department with the highest average salary.
-- 264. Find the latest order for every customer.
-- 265. Find consecutive duplicate records.
-- 266. Find missing IDs.
-- 267. Generate row numbers.
-- 268. Rank employees by salary.
-- 269. Calculate running totals.
-- 270. Calculate cumulative sales.
-- 271. Find the median salary.
-- 272. Pivot rows into columns.
-- 273. Unpivot columns into rows (concept).
-- 274. Remove duplicate values while keeping one record.
-- 275. Identify orphan records.
-- 276. Detect invalid foreign key relationships.
-- 277. Find customers with orders in every month.
-- 278. Calculate month-over-month growth.
-- 279. Find the busiest sales day.
-- 280. Find products with declining sales.
-- 281. Design a banking database.
-- 282. Design an e-commerce database.
-- 283. Design a hospital management database.
-- 284. Design a library management system.
-- 285. Design a payroll system.
-- 286. Design an inventory management system.
-- 287. Design a food delivery application database.
-- 288. Design a social media database.
-- 289. Design a hotel booking database.
-- 290. Explain your database design choices.
-- 291. How would you scale this database to millions of rows?
-- 292. How would you archive old data?
-- 293. How would you improve reporting performance?
-- 294. How would you handle concurrent updates?
-- 295. How would you secure sensitive customer data?
-- 296. How would you migrate a database with minimal downtime?
-- 297. How would you investigate data inconsistencies?
-- 298. How would you recover from accidental data deletion?
-- 299. Describe a challenging SQL problem you've solved.
-- 300. Walk through the optimization of a complex query from start to finish.

-- Bonus: Frequently Asked SQL Interview Coding Problems

-- Second, third, and nth highest salary
-- Duplicate records (find and remove)
-- Employees earning more than their manager
-- Customers with no orders
-- Products never sold
-- Top N records per group
-- Running totals
-- Ranking with window functions
-- Gaps and islands problems
-- Median salary
-- Consecutive dates
-- Monthly sales reports
-- Pivot and unpivot operations
-- Recursive queries (CTEs)
-- Pagination
-- Hierarchical employee reporting
