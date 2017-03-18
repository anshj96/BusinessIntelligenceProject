# BusinessIntelligenceProject

	/*Upasana Roy, Ansh Jain, and Andrew Piispanen
	CVS Project*/

	CREATE DATABASE CVS;
	GO

	USE CVS;

	-- Create the Order, Orderline, Doctor, Customer, Cashier, Prescription, Supplier, Product, and ProductCategory tables

	CREATE TABLE Product(
	  ProductID bigint NOT NULL PRIMARY KEY,
	  Name varchar(50) NOT NULL,
	  ProductCategoryID bigint NOT NULL, 
	  SupplierID bigint NOT NULL);

	CREATE TABLE ProductCategory(
	  ProductCategoryID bigint NOT NULL PRIMARY KEY,
	  Name varchar(50) NOT NULL);

	CREATE TABLE Doctor(
	  DoctorID bigint NOT NULL PRIMARY KEY,
	  FirstName varchar(50) NOT NULL,
	  LastName varchar(50) NOT NULL);

	CREATE TABLE Orderline(
	  OrderlineID bigint NOT NULL PRIMARY KEY,
	  OrderID bigint NOT NULL,
	  ProductID bigint NOT NULL,
	  UnitPrice bigint NOT NULL,
	  QTY bigint NOT NULL);

	CREATE TABLE Orders(
	  OrderID bigint NOT NULL PRIMARY KEY,
	  CashierID bigint NOT NULL,
	  CustomerID bigint NOT NULL,
	  OrderDate date NOT NULL);
  
	CREATE TABLE Customer(
	  CustomerID bigint NOT NULL PRIMARY KEY,
	  FirstName varchar(50) NULL,
	  LastName varchar(50) NULL,
	  Birthdate date NULL,
	  Address varchar(50) NULL,
	  CC# bigint NULL,
	  DoctorID bigint NULL);

	/*The prescription table is used as a separate order table for prescription drugs. 
	Like at a large-chain pharmacy, transactions for payment occur at both the front cash register and at the actual pharmacy,
	making them two separate tables in our database (Prescription and Order).*/

	CREATE TABLE Prescription(
	  PrescriptionID bigint NOT NULL PRIMARY KEY,
	  CustomerID bigint NOT NULL,
	  DoctorID bigint NOT NULL,
	  ProductID bigint NOT NULL,
	  QTY bigint NOT NULL,
	  TotalCost bigint NOT NULL,
	  DateIssued date NOT NULL,
	  DateFilled Date NULL);

	CREATE TABLE Supplier(
	  SupplierID bigint NOT NULL PRIMARY KEY,
	  Name varchar(50) NOT NULL,
	  Address varchar(50) NOT NULL); 

	  CREATE TABLE Cashier(
	  CashierID bigint NOT NULL PRIMARY KEY,
	  FirstName varchar(50) NOT NULL,
	  LastName varchar(50) NOT NULL,
	  Address varchar(50) NOT NULL); 

	-- Create the relationships: 
	ALTER TABLE Product ADD CONSTRAINT FK_Product_SupplierID 
	FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID);

	ALTER TABLE Product ADD CONSTRAINT FK_Product_ProductCategoryID 
	FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategory(ProductCategoryID);

	ALTER TABLE Orderline ADD CONSTRAINT FK_Orderline_OrderID
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);

	ALTER TABLE Orderline ADD CONSTRAINT FK_Orderline_ProductID
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID);

	ALTER TABLE Orders ADD CONSTRAINT FK_Orders_CashierID 
	FOREIGN KEY (CashierID) REFERENCES Cashier(CashierID);

	ALTER TABLE Orders ADD CONSTRAINT FK_Orders_CustomerID
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

	ALTER TABLE Prescription ADD CONSTRAINT FK_Prescription_CustomerID
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

	ALTER TABLE Prescription ADD CONSTRAINT FK_Prescription_DoctorID
	FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID);

	ALTER TABLE Prescription ADD CONSTRAINT FK_Prescription_ProductID
	FOREIGN KEY (ProductID) REFERENCES Product(ProductID);

	--Inserting Records Into The Tables

	INSERT INTO Doctor (DoctorID, FirstName, LastName) VALUES 
	(1, 'Jimmy', 'Johnson'),
	(2, 'Upasana', 'Roy'),
	(3, 'Elvis', 'Ge'),
	(4, 'Fred', 'Jay'),
	(5, 'Gerald', 'Goldfish'),
	(6, 'David', 'Washington'),
	(7, 'Adam', 'Smith'),
	(8, 'Danielle', 'Beauford'),
	(9, 'Christina', 'Davidson'),
	(10, 'Michelle', 'Harvey');

	INSERT INTO Customer (CustomerID, FirstName, LastName, Birthdate, Address, CC#, DoctorID) VALUES 
	(1, 'Francesca', 'James', '01/31/1996', '', NULL , 1),
	(2, 'Harold', 'Jones', '06/24/1956', '14 Carrotwood Drive', '012312387123', 2),
	(3, 'Ansh', 'Jain', '02/21/1996', '23 Forest Street', '02343238712', 3),
	(4, 'Francis', 'Harrington', '10/07/1978', '', '82832823837', 9),
	(5, 'Gerald', 'Flannigan', '01/23/1946', '', Null ,4),
	(6, 'Justin', 'Joseph', '04/25/1990', '', Null, 6),
	(7, 'Adam', 'Smith', '11/14/1993', '14 Indibitable Drive', '21123213981', 7),
	(8, 'Harry', 'Potter', '07/31/1980', '4 Privet Drive', '3139879387', 5),
	(9, 'Brianna', 'Angryson', '09/19/1987', '', NULL, NULL),
	(10, 'Rodger', 'Babson', '07/06/1875', '34 Main Street', Null, 4);

	INSERT INTO Cashier(CashierID, FirstName, LastName, Address) VALUES
	(1, 'James', 'Madison', '45 First Street'),
	(2, 'John', 'Johnson', '3 Briarwood Lane'),
	(3, 'Nicole', 'Ciavola', '231 Forest Street'),
	(4, 'Frederick', 'Dooble', '293 Main Street');

	INSERT INTO Orders(OrderID, CustomerID, CashierID, OrderDate) VALUES 
	(1, 7, 2, '01/12/2016'),
	(2, 3, 4,'04/02/2016'),
	(3, 2, 1,'10/18/2016'),
	(4, 2, 3,'05/12/2016'),
	(5, 9, 1,'09/04/2016'),
	(6, 6, 2,'11/25/2016'),
	(7, 8, 1,'12/24/2016'),
	(8, 9, 3,'07/23/2016'),
	(9, 9, 3,'04/05/2016'),
	(10, 3, 4,'07/13/2016');

	INSERT INTO Supplier(SupplierID, Name, Address) VALUES
	(1, 'OTC United', '45 Bentwood Ave'),
	(2, 'Johnson & Johnson', '1929 Main Street'),
	(3, 'Food Galore', '525 Yogurt Way'),
	(4, 'Drinks R Us', '735 Blast Path'),
	(5, 'Pfizer', '7 Johnson rd'),
	(6, 'Proctor & Gamble', '28 Commercial Path'),
	(7, 'Kelloggs', '473 Main Street'),
	(8, 'GSK', '11 Rebate Way'),
	(9, 'Novartis', '62 Mass Ave'),
	(10, 'Clarkston Drug Co.', '339 Shirley Way');

INSERT INTO ProductCategory(ProductCategoryID, Name) VALUES 
	(1, 'OTC Drug'),
	(2, 'Rx Drug'),
	(3, 'Food & Beverage'),
	(4, 'Miscellaneous'),
	(5, 'Cosmetics');

INSERT INTO Product(ProductID, Name, ProductCategoryID, SupplierID) VALUES 
	(1, 'Tylenol', 1, 2),
	(2, 'Sprite', 3, 6), 
	(3, 'Haloween Necklace', 4, 6), 
	(4, 'Albuterol', 2, 10),
	(5, 'Prilosec OTC', 1,  1),
	(6, 'Prevacid Rx', 2, 8),
	(7, 'Band-Aid', 1, 2),
	(8, 'Chips Ahoy Cookies', 3, 3),
	(9, 'Zyrtec', 1, 5),
	(10, 'Specialized Prescription', 2,10);
	
INSERT INTO Orderline(OrderlineID, OrderID, UnitPrice, QTY, ProductID) VALUES 
	(1,1,5,10,1),
	(2,1,12,5,3),
	(3,3,5,4,2),
	(4,5,40,20,7),
	(5,9,10,3,9),
	(6,7,8,9,1),
	(7,2,7,7,5),
	(8,5,5,1,2),
	(9,2,3,50,3),
	(10,3,15,3,8);

INSERT INTO Prescription(PrescriptionID, CustomerID, DoctorID, ProductID, QTY, TotalCost, DateIssued, Datefilled) VALUES
	(1, 1,5,4,1,500,'01/12/2016', '04/05/2016'),
	(2,6,4,6,4,23, '10/02/2016', '10/05/2016'),
	(3,3,3,7,12,175, '11/18/2016', '11/27/2016'),
	(4,7,2,10,15,145, '02/12/2016', '02/28/2016'),
	(5,9,6,4,40,130, '01/04/2016', '01/05/2016'),
	(6,5,1,6,31, 153, '11/25/2016', '11/29/2016'),
	(7,3,6,10,29, 164.75, '12/24/2016', '12/30/2016'),
	(8,9,10,7,1, 328.64, '02/23/2016', '02/23/2016'),
	(9,2,2,7,4, 15.99, '04/05/2016', '04/05/2016'),
	(10,5,3,4,20, 1050.80, '04/27/2016', '04/28/2016');

	-- Some queries
	SELECT * FROM Supplier;
	SELECT * FROM Doctor;
	SELECT * FROM Customer;
	SELECT * FROM ORDERS;
	SELECT * FROM Orderline;
	SELECT * FROM Prescription;
	SELECT * FROM Cashier;
	SELECT * FROM Product;
	SELECT * FROM ProductCategory;
	
	GO
