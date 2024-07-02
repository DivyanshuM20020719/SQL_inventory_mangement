CREATE DATABASE Inventory_management;
USE Inventory_management;
-- Create the tables
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description VARCHAR(255),
    Price DECIMAL(10, 2),
    StockQuantity INT
);

CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    Name VARCHAR(100),
    ContactInfo VARCHAR(255)
);

CREATE TABLE ProductSuppliers (
    ProductID INT,
    SupplierID INT,
    PRIMARY KEY (ProductID, SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    ContactInfo VARCHAR(255)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert sample data
INSERT INTO Products (ProductID, Name, Description, Price, StockQuantity)
VALUES 
    (1, 'Laptop', 'High performance laptop', 1200.00, 10),
    (2, 'Monitor', '27-inch LED monitor', 300.00, 15),
    (3, 'Keyboard', 'Mechanical gaming keyboard', 100.00, 20);

INSERT INTO Suppliers (SupplierID, Name, ContactInfo)
VALUES 
    (1, 'Supplier A', 'supplier_a@example.com'),
    (2, 'Supplier B', 'supplier_b@example.com');

INSERT INTO ProductSuppliers (ProductID, SupplierID)
VALUES 
    (1, 1),
    (2, 1),
    (3, 2);

INSERT INTO Customers (CustomerID, Name, ContactInfo)
VALUES 
    (1, 'Customer X', 'customer_x@example.com'),
    (2, 'Customer Y', 'customer_y@example.com');

INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES 
    (1, 1, '2024-02-01'),
    (2, 2, '2024-02-03');

INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES 
    (1, 1, 2),
    (1, 2, 1),
    (2, 3, 3);

-- Example queries

-- Query to retrieve all products
SELECT * FROM Products;

-- Query to retrieve all suppliers
SELECT * FROM Suppliers;

-- Query to retrieve all customers
SELECT * FROM Customers;

-- Query to retrieve all orders
SELECT * FROM Orders;

-- Query to retrieve all order details
SELECT * FROM OrderDetails;

-- Query to retrieve total sales for each product
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    SUM(od.Quantity) AS TotalSales
FROM 
    Products p
JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
GROUP BY 
    p.ProductID, p.Name;

-- Query to retrieve products with low stock
SELECT * FROM Products WHERE StockQuantity < 5;

-- Query to retrieve total amount of sales of each product
SELECT orderdetails.ProductID, products.Name, orderdetails.Quantity*products.Price AS TotalSales
FROM orderdetails, products
WHERE orderdetails.ProductID = products.ProductID
GROUP BY products.ProductID, products.Name, TotalSales
ORDER BY ProductID ASC;
