-- Step 1: Create the Database
CREATE DATABASE CustomerDB;
USE CustomerDB;

-- Step 2: Create the Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE,
    ManagerID INT
);

-- Step 3: Create the Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    HireDate DATE,
    Salary DECIMAL(10, 2) CHECK (Salary > 0),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE SET NULL
);

-- Step 4: Create the Financials Table
CREATE TABLE Financials (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    TransactionDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    Amount DECIMAL(15, 2) NOT NULL CHECK (Amount >= 0),
    TransactionType ENUM('Income', 'Expense') NOT NULL,
    Description TEXT
);

-- Step 5: Create the Inventory Table
CREATE TABLE Inventory (
    ItemID INT PRIMARY KEY AUTO_INCREMENT,
    ItemName VARCHAR(100) NOT NULL UNIQUE,
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    PricePerUnit DECIMAL(10, 2) NOT NULL CHECK (PricePerUnit > 0),
    SupplierID INT
);

-- Step 6: Create the Sales Table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    SaleDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    CustomerName VARCHAR(100),
    TotalAmount DECIMAL(15, 2) CHECK (TotalAmount >= 0),
    ItemID INT,
    QuantitySold INT CHECK (QuantitySold > 0),
    FOREIGN KEY (ItemID) REFERENCES Inventory(ItemID) ON DELETE CASCADE
);

-- Step 7: Create the Procurement Table
CREATE TABLE Procurement (
    ProcurementID INT PRIMARY KEY AUTO_INCREMENT,
    ProcurementDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    SupplierName VARCHAR(100),
    ItemID INT,
    QuantityProcured INT CHECK (QuantityProcured > 0),
    TotalCost DECIMAL(15, 2) CHECK (TotalCost >= 0),
    FOREIGN KEY (ItemID) REFERENCES Inventory(ItemID) ON DELETE CASCADE
);

-- Step 8: Insert Data into Departments
INSERT INTO Departments (DepartmentName, ManagerID) VALUES 
('Human Resources', NULL), 
('Finance', NULL), 
('Sales', NULL), 
('IT', NULL);

-- Step 9: Insert Data into Employees
INSERT INTO Employees (FirstName, LastName, DepartmentID, HireDate, Salary) VALUES 
('John', 'Doe', 1, '2023-01-15', 60000.00), 
('Jane', 'Smith', 2, '2023-03-22', 70000.00), 
('Emily', 'Davis', 3, '2023-05-30', 55000.00), 
('Michael', 'Brown', 4, '2023-07-10', 80000.00);

-- Step 10: Assign Managers to Departments
UPDATE Departments SET ManagerID = 1 WHERE DepartmentID = 1;
UPDATE Departments SET ManagerID = 2 WHERE DepartmentID = 2;
UPDATE Departments SET ManagerID = 3 WHERE DepartmentID = 3;
UPDATE Departments SET ManagerID = 4 WHERE DepartmentID = 4;

-- Step 11: Insert Data into Inventory
INSERT INTO Inventory (ItemName, Quantity, PricePerUnit, SupplierID) VALUES 
('Laptop', 50, 1200.00, 1), 
('Office Chair', 100, 150.00, 2), 
('Printer', 20, 300.00, 3);

-- Step 12: Insert Data into Sales
INSERT INTO Sales (SaleDate, CustomerName, TotalAmount, ItemID, QuantitySold) VALUES 
('2024-01-15', 'Fathima', 2400.00, 1, 2), 
('2024-01-20', 'Shafeeka', 450.00, 2, 3);

-- Step 13: Insert Data into Procurement
INSERT INTO Procurement (ProcurementDate, SupplierName, ItemID, QuantityProcured, TotalCost) VALUES 
('2024-01-05', 'Tech Supplies Co.', 1, 10, 12000.00), 
('2024-01-10', 'Furniture Ltd.', 2, 20, 3000.00);

-- Step 14: Retrieve All Data
SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Financials;
SELECT * FROM Inventory;
SELECT * FROM Sales;
SELECT * FROM Procurement;

-- Step 15: Delete Unwanted Data
DELETE FROM Employees WHERE EmployeeID > 4;
DELETE FROM Sales WHERE SaleID > 0;
DELETE FROM Inventory WHERE ItemID > 4;
DELETE FROM Procurement WHERE ProcurementID > 2;

-- Step 16: Retrieve Unique Item Names
SELECT DISTINCT ItemName FROM Inventory;

-- Step 17: Describe Table Structure
DESCRIBE Employees;