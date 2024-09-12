use CustomerOrderDB;


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    Phone NVARCHAR(15),
    Address NVARCHAR(255)
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100),
    Price DECIMAL(10, 2),
    Stock INT
);
select*from Customers;

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    OrderDate DATE DEFAULT GETDATE(),
    Quantity INT,
    TotalAmount DECIMAL(10, 2)
);

CREATE TRIGGER trg_CalculateTotalAmount
ON Orders
AFTER INSERT
AS
BEGIN
    UPDATE O
    SET O.TotalAmount = I.Quantity * P.Price
    FROM Orders O
    INNER JOIN inserted I ON O.OrderID = I.OrderID
    INNER JOIN Products P ON I.ProductID = P.ProductID;
END;

INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES
('John', 'Doe', 'johndoe@email.com', '123-456-7890', '123 Elm St'),
('Jane', 'Smith', 'janesmith@email.com', '987-654-3210', '456 Oak St');

INSERT INTO Products (ProductName, Price, Stock)
VALUES
('Laptop', 999.99, 10),
('Smartphone', 499.99, 20),
('Tablet', 299.99, 15);

INSERT INTO Orders (CustomerID, ProductID, Quantity)
VALUES (1, 1, 2);  -- John Doe orders 2 Laptops

SELECT O.OrderID, C.FirstName, C.LastName, P.ProductName, O.Quantity, O.TotalAmount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON O.ProductID = P.ProductID;

CREATE PROCEDURE AddCustomer
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(15),
    @Address NVARCHAR(255)
AS
BEGIN
    INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
    VALUES (@FirstName, @LastName, @Email, @Phone, @Address);
END;

CREATE PROCEDURE AddProduct
    @ProductName NVARCHAR(100),
    @Price DECIMAL(10, 2),
    @Stock INT
AS
BEGIN
    INSERT INTO Products (ProductName, Price, Stock)
    VALUES (@ProductName, @Price, @Stock);
END;

CREATE PROCEDURE PlaceOrder
    @CustomerID INT,
    @ProductID INT,
    @Quantity INT
AS
BEGIN
    INSERT INTO Orders (CustomerID, ProductID, Quantity)
    VALUES (@CustomerID, @ProductID, @Quantity);
END;

SELECT OrderDate, SUM(TotalAmount) AS DailySales
FROM Orders
GROUP BY OrderDate;




