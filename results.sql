
-- View Customers table schema
EXEC sp_columns Customers;

-- View Products table schema
EXEC sp_columns Products;

-- View Orders table schema
EXEC sp_columns Orders;

INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('Alice', 'Brown', 'alice.brown@email.com', '123-456-7890', '789 Maple St');

INSERT INTO Products (ProductName, Price, Stock)
VALUES ('Desktop', 799.99, 25);

INSERT INTO Orders (CustomerID, ProductID, Quantity)
VALUES (1, 1, 3);  -- Customer 1 orders 3 units of Product 1

-- View Customers
SELECT * FROM Customers;

-- View Products
SELECT * FROM Products;

-- View Orders and check if TotalAmount is calculated
SELECT O.OrderID, C.FirstName, C.LastName, P.ProductName, O.Quantity, O.TotalAmount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON O.ProductID = P.ProductID;

-- Check if the TotalAmount is calculated correctly
SELECT * FROM Orders;

EXEC AddCustomer 'Bob', 'White', 'bob.white@email.com', '987-654-3210', '101 Pine St';

EXEC AddProduct 'Monitor', 149.99, 50;

EXEC PlaceOrder 2, 2, 5;  -- Customer 2 orders 5 units of Product 2

-- Sales Report by Order Date
SELECT OrderDate, SUM(TotalAmount) AS DailySales
FROM Orders
GROUP BY OrderDate;

-- Backup your database (replace 'YourDatabase' with your actual database name)
---BACKUP DATABASE YourDatabase TO DISK = 'C:\backup\CustomerOrderDB.bak';







