-- 1. Create a new database named SalesDB
CREATE DATABASE SalesDB;

-- 2. Use the newly created database
USE SalesDB;

-- 3. Create a table named Orders with the specified schema
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATETIME,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2) -- DECIMAL(precision, scale) for monetary values
);

-- 4. Populate the Orders table with sample data
INSERT INTO Orders (OrderDate, CustomerID, TotalAmount) VALUES
('2023-01-15 10:00:00', 101, 250.75),
('2023-01-15 10:30:00', 102, 120.00),
('2023-01-16 11:15:00', 101, 300.50),
('2023-01-17 14:45:00', 103, 75.20),
('2023-01-18 09:00:00', 102, 450.00);

-- Optional: Verify the data
SELECT * FROM Orders;