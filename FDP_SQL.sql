CREATE DATABASE FDP;
USE FDP;
CREATE TABLE Customers (
customer_id INT PRIMARY KEY,
name VARCHAR(50),
city VARCHAR(50)
);
INSERT INTO Customers (customer_id, name, city) VALUES
(1, 'Arjun', 'Bengaluru'),
(2, 'Sneha', 'Hyderabad'),
(3, 'Rahul', 'Chennai'),
(4, 'Priya', 'Bengaluru'),
(5, 'Kiran', 'Mumbai'),
(6, 'Divya', 'Bengaluru'),
(7, 'Vikram', 'Hyderabad'),
(8, 'Asha', 'Chennai'),
(9, 'Manoj', 'Pune'),
(10, 'Swathi', 'Bengaluru');
CREATE TABLE Orders (
order_id INT PRIMARY KEY,
customer_id INT,
restaurant VARCHAR(50),
amount DECIMAL(10,2),
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
INSERT INTO Orders (order_id, customer_id, restaurant, amount, order_date) VALUES
(101, 1, 'Meghana Foods', 550.00, '2025-01-01'),
(102, 2, 'Paradise Biryani', 780.00, '2025-01-03'),
(103, 3, 'KFC', 420.00, '2025-01-05'),
(104, 1, 'Empire Restaurant', 300.00, '2025-01-08'),
(105, 4, 'Meghana Foods', 950.00, '2025-01-10'),
(106, 6, 'Truffles', 1100.00, '2025-01-11'),
(107, 7, 'Kritunga', 650.00, '2025-01-12'),
(108, 4, 'KFC', 350.00, '2025-01-14'),
(109, 9, 'Burger King', 270.00, '2025-01-15'),
(110, 10, 'Meghana Foods', 1250.00, '2025-01-16');
SELECT customer_id, name FROM customers 
WHERE customer_id IN (SELECT customer_id FROM orders);
SELECT c.name, SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
select c.customer_id,c.name, sum(o.amount) as total_spent from customers c
join orders o on c.customer_id-o.customer_id
group by c.customer_id, c.name
order by total_spent desc limit 3;
SELECT *FROM Orders
WHERE Order_date >=
 (SELECT MAX(Order_date) FROM Orders) - INTERVAL 7 DAY;
 SELECT c.Customer_id, c.name FROM Customers c
LEFT JOIN Orders o ON c.Customer_id = o.Customer_id
WHERE o.Customer_id IS NULL;
SELECT c.Customer_id, c.name, c.City, SUM(o.amount) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.Customer_id = o.Customer_id
WHERE c.City = 'Bengaluru'
GROUP BY c.Customer_id, c.name, c.City
HAVING TotalSpent > 1000;
select c.city,count(o.order_id) as totalorders  from customers c
join orders o on c.customer_id=o.customer_id
group by c.city
order by totalorders desc;
SELECT Restaurant, AVG(amount) AS AverageOrderAmount FROM Orders
GROUP BY Restaurant
ORDER BY AverageOrderAmount DESC;
SELECT Customer_id, COUNT(Order_id) AS TotalOrders
FROM Orders
GROUP BY Customer_id
HAVING TotalOrders > 5
ORDER BY TotalOrders DESC;