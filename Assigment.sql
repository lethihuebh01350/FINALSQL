CREATE DATABASE asm22;
USE asm22;
-- Xóa các bảng nếu đã tồn tại (làm điều này trước khi tạo lại)
-- Tạo bảng Customer
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(50),
	Gender VARCHAR(10),
    Birth DATE,
    Phone VARCHAR(20),
    Email NVARCHAR(100),
);
INSERT INTO Customer (CustomerName, Gender, Birth, Phone, Email)
VALUES
    (N'John Doe', 'Male', '1990/01/15', '1234567890', '@123 Elm Street'),
    (N'Jane Smith', 'Female', '1985/07/25', '9876543210', '@456 Oak Avenue'),
    (N'Alex Johnson', 'Female', '2000/03/10', '5551234567', '@789 Pine Road'),
    (N'Emily Davis', 'Female', '1995/06/30', '4445678901', '@321 Maple Lane');

--SELECT CustomerID, CustomerName, Gender, Email FROM Customer;
--UPDATE Customer
--SET Email = '@123 Elm Street'
--WHERE CustomerID = 1;

--DELETE Customer
--WHERE CustomerID = 3;

-- Tạo bảng Product
CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Image VARBINARY(MAX),
    Name NVARCHAR(50),
    Size NVARCHAR(20),
    InputPrice DECIMAL(10,2),
    InventoryPrice DECIMAL(10,2),
    SellingPrice DECIMAL(10,2),
);

-- Tạo bảng CustomerProduct (mối quan hệ nhiều-nhiều giữa Customer và Product)
CREATE TABLE CustomerProduct (
    CustomerProductID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    ProductID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
INSERT INTO CustomerProduct(CustomerID, ProductID)
SELECT DISTINCT CustomerID, ProductID
FROM Customer 
CROSS JOIN Product;

-- Tạo bảng Employee
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50),
    Phone VARCHAR(20),
    Email NVARCHAR(50),
    Position NVARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10, 2)
);
INSERT INTO Employee (Name, Phone, Email, Position, HireDate, Salary)
VALUES
    (N'CAOTHIVAN', '0889747478', 'van12345@gmail.com', 'Manager', '2023-01-01', 5000.00),
    (N'LEGIAHOANGANH', '0352434304', 'hoanganh890@gmail.com', 'Assistant', '2024-06-01', 3000.00);

CREATE TABLE Users (
    UsersID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    CustomerID INT,
    UserName VARCHAR(50),
    PasswordHash VARCHAR(255),
    Salt VARCHAR(255),
    Role VARCHAR(10) CHECK (Role IN ('Admin', 'User')) NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Tạo bảng Statistic (tham chiếu đến CustomerProduct, Employee và User)
CREATE TABLE Statistic (
    StatisticID INT PRIMARY KEY IDENTITY(1,1),
    CustomerProductID INT,
    EmployeeID INT,
	ProductID INT,
    QuantitySold INT,
    SaleDate DATE,
    TotalPrice DECIMAL(10,2),
	InputPrice DECIMAL(18,2),
    FOREIGN KEY (CustomerProductID) REFERENCES CustomerProduct(CustomerProductID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
INSERT INTO Statistic (CustomerProductID, EmployeeID, ProductID, QuantitySold, SaleDate, TotalPrice, InputPrice)
VALUES
    (1, 1, 1, 10, '2023-11-20', 600.00, 500.00),
    (2, 2, 2, 5, '2023-11-21', 275.00, 200.00);
 -- Đảm bảo CustomerProductID = 1 tồn tại trong CustomerProduct

-- Xóa các bảng sau khi sử dụng (thực hiện phần này sau khi kiểm tra dữ liệu)
 DROP TABLE IF EXISTS Statistic;
 DROP TABLE IF EXISTS CustomerProduct;
 DROP TABLE IF EXISTS Employee;
 DROP TABLE IF EXISTS Product;
 DROP TABLE IF EXISTS Customer;
 DROP TABLE IF EXISTS Users;