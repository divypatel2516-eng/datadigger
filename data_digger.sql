-- Data Digger

CREATE DATABASE IF NOT EXISTS DataDigger;
USE DataDigger;

-- Remove old tables so this file can be run again
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Address VARCHAR(150)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    SubTotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- 1. Customers
INSERT INTO Customers VALUES
(1, 'Alice', 'alice@example.com', 'Ahmedabad'),
(2, 'Rahul', 'rahul@example.com', 'Surat'),
(3, 'Priya', 'priya@example.com', 'Vadodara'),
(4, 'Jay', 'jay@example.com', 'Rajkot'),
(5, 'Meera', 'meera@example.com', 'Gandhinagar');

SELECT * FROM Customers;

UPDATE Customers
SET Address = 'Navrangpura, Ahmedabad'
WHERE CustomerID = 1;

DELETE FROM Customers
WHERE CustomerID = 5;

SELECT * FROM Customers
WHERE Name = 'Alice';

-- 2. Orders
INSERT INTO Orders VALUES
(101, 1, CURDATE() - INTERVAL 5 DAY, 25000.00),
(102, 2, CURDATE() - INTERVAL 12 DAY, 8500.00),
(103, 1, CURDATE() - INTERVAL 20 DAY, 42000.00),
(104, 3, CURDATE() - INTERVAL 2 DAY, 12000.00),
(105, 4, CURDATE() - INTERVAL 40 DAY, 6000.00);

SELECT * FROM Orders
WHERE CustomerID = 1;

UPDATE Orders
SET TotalAmount = 27000.00
WHERE OrderID = 101;

-- Order 105 has no OrderDetails, so it can be deleted safely.
DELETE FROM Orders
WHERE OrderID = 105;

SELECT * FROM Orders
WHERE OrderDate >= CURDATE() - INTERVAL 30 DAY;

SELECT MAX(TotalAmount) AS HighestAmount,
       MIN(TotalAmount) AS LowestAmount,
       AVG(TotalAmount) AS AverageAmount
FROM Orders;

-- 3. Products
INSERT INTO Products VALUES
(201, 'Laptop', 65000.00, 8),
(202, 'Smartphone', 32000.00, 15),
(203, 'Headphones', 2500.00, 20),
(204, 'Tablet', 18000.00, 10),
(205, 'Keyboard', 1500.00, 0);

SELECT * FROM Products
ORDER BY Price DESC;

UPDATE Products
SET Price = 62000.00
WHERE ProductID = 201;

-- Product 205 is not used in OrderDetails, so it can be deleted safely.
DELETE FROM Products
WHERE Stock = 0 AND ProductID = 205;

SELECT * FROM Products
WHERE Price BETWEEN 7500 AND 72000;

SELECT MAX(Price) AS MostExpensivePrice,
       MIN(Price) AS CheapestPrice
FROM Products;

-- 4. OrderDetails
INSERT INTO OrderDetails VALUES
(1, 101, 201, 1, 62000.00),
(2, 102, 203, 2, 5000.00),
(3, 103, 202, 1, 32000.00),
(4, 104, 204, 1, 18000.00),
(5, 101, 202, 1, 32000.00);

SELECT * FROM OrderDetails
WHERE OrderID = 101;

SELECT SUM(SubTotal) AS TotalRevenue
FROM OrderDetails;

SELECT p.ProductID, p.ProductName, SUM(od.Quantity) AS TotalOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalOrdered DESC
LIMIT 3;

SELECT COUNT(*) AS TimesSold
FROM OrderDetails
WHERE ProductID = 202;
