create database [Hotel Management System]

-----------1st-Table-Customers Table------------
create table Customers
(
	[Customer ID] int primary key identity(10000, 1),
	[Customer First name] nvarchar(MAX),
	[Customer Last name] nvarchar(MAX),
	[Customer Address] nvarchar(MAX),
	[No. of Peoples] int
)
create table [Customer's Phone No.s]
(
	[Customer ID] int, foreign key([Customer ID]) references Customers([Customer ID]),
	[Customer Phone No.s] bigint
)
Select * from Customers
Select * from [Customer's Phone No.s]
-----------Customers Final Table output------------
CREATE VIEW [CUSTOMERS VIEW]
AS
	Select Customers.[Customer ID], [Customer First name], [Customer Last name], [Customer Address], [No. of Peoples], [Customer Phone No.s]
	from Customers 
	INNER JOIN [Customer's Phone No.s]
		ON Customers.[Customer ID] = [Customer's Phone No.s].[Customer ID]
GO
Select * from [CUSTOMERS VIEW]
-----------Customers Final Table output------------
-----------Customers Table------------

-----------2nd-Table-Payments Table-------------
create table Payments
(
	[Payment ID] int primary key identity(90000, 1),
	[Customer ID] int, foreign key([Customer ID]) references Customers([Customer ID]),
	[Amount] money,
	[Payment Date] Date
)
Select * from Payments
-----------2nd-Table-Payments Table-------------

-----------3rd-Table-Payments Table-------------
create table Reviews
(
	[Customer ID] int, foreign key([Customer ID]) references Customers([Customer ID]),
	[Review Details] nvarchar(MAX),
	[Review Date] Date
)
Select * from Reviews
-----------Reviews Final Table output------------
CREATE VIEW [CUSTOMERS REVIEWS]
AS
	Select Customers.[Customer ID], [Customer First name], [Customer Last name], Reviews.[Review Details], Reviews.[Review Date] 
	from Customers 
	RIGHT JOIN [Reviews] 
		ON Customers.[Customer ID] = [Reviews].[Customer ID]
GO
Select * from [CUSTOMERS REVIEWS]
-----------Reviews Final Table output------------
-----------3rd-Table-Payments Table-------------


-----------4th-Table-Employees Table-------------
create table Employees
(
	[Employee ID] int primary key identity(2000, 1),
	[Employee First Name] nvarchar(MAX),
	[Employee Last Name] nvarchar(MAX),
	[Employee Department] nvarchar(MAX),
	[Employee Address] nvarchar(MAX),
	[Employee Salary] money
)
create table [Employees Contact No.s]
(
	[Employee ID] int, foreign key([Employee ID]) references Employees([Employee ID]),
	[Employee Contact No.s] bigint
)
create table [Login]
(
	[Username] nvarchar(50),
	[Password] nvarchar(50)
)