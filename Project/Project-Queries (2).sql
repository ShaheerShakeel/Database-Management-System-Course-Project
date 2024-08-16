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
	[Amount] bigint,
	[Payment Date] Date
)
Select * from Payments
update Payments Set Payments.[Amount]=(Select [Rent] from Rooms)*(Select [Interval of Stay] from Reservations)
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
	[Username] nvarchar(50),
	[Password] nvarchar(50),
	[Employee Department] nvarchar(MAX),
	[Employee Address] nvarchar(MAX),
	[Employee Salary] money
)
create table [Employees Contact No.s]
(
	[Employee ID] int, foreign key([Employee ID]) references Employees([Employee ID]),
	[Employee Contact No.s] bigint
)
Select * from Employees
Select * from [Employees Contact No.s]
----------------Employees Final Table output---------
CREATE VIEW [EMPLOYEES VIEW]
AS
	Select Employees.[Employee ID], [Employee First name], [Employee Last name], [Username], [Password], [Employee Department], [Employee Address], [Employee Salary], [Employees Contact No.s].[Employee Contact No.s]
	from Employees
	INNER JOIN [Employees Contact No.s]
		ON Employees.[Employee ID] = [Employees Contact No.s].[Employee ID]
GO
Select * from [EMPLOYEES VIEW]
----------------Employees Final Table output---------
-----------4th-Table-Employees Table-------------


-----------5th-Table-Transactions Table-------------
create table Transactions
(
	[Transaction ID] int primary key identity(1, 1),
	[Transaction Name] nvarchar(50),
	[Customer ID] int, foreign key([Customer ID]) references Customers([Customer ID]),
	[Employee ID] int, foreign key([Employee ID]) references Employees([Employee ID]),
	[Transaction Date] Date
)
-----------5th-Table-Transactions Table-------------


-----------6th-Table-Room Table-------------
create table Rooms
(
	[Room No] int primary key identity(100, 1),
	[Room Category] nvarchar(MAX),
	[Rent] bigint unique
)
Select * from Rooms
delete from Rooms where [Room No] = 100
update Rooms Set [Room Category] = 'Economy', Rent = 3000, [Reservation ID] = 1008 where [Room No] = 100
alter table Rooms add [Reservation ID] int, foreign key([Reservation ID]) references Reservations([Reservation ID])
-----------6th-Table-Room Table-------------



----------------Transaction Final Table output for slip---------
CREATE VIEW [TRANSACTIONS VIEW]
AS
	Select Transactions.[Transaction ID],Transactions.[Transaction Name],Transactions.[Transaction Date], Transactions.[Customer ID], Payments.[Amount], Payments.[No. of Days Stay]
	from Transactions
	LEFT JOIN [Payments] 
		ON Transactions.[Transaction ID]=[Payments].[Transaction ID]
GO

Select * from [TRANSACTIONS VIEW]
Select * from Payments
Select * from Transactions
----------------Transaction Final Table output for slip---------

alter table Payments add [Transaction ID] int, foreign key([Transaction ID]) references Transactions([Transaction ID])

-----------7th-Table-Reservation Table------
create table Reservations
(
	[Reservation ID] int primary key identity(1000, 1),
	[Transaction ID] int, foreign key([Transaction ID]) references Transactions([Transaction ID]),
	[Customer ID] int, foreign key([Customer ID]) references Customers([Customer ID]),
	[Date In] Date,
	[Date Out] Date,
	[Interval of Stay] bigint
)
Select * from Reservations
Select * from Rooms
----------------Reservation Final Table output for slip---------
CREATE VIEW [RESERVATIONS VIEW]
AS
	Select Reservations.[Reservation ID], Reservations.[Transaction ID], Reservations.[Customer ID], Reservations.[Date In], Reservations.[Date Out], Reservations.[Interval of Stay], Reservations.[Room No.], Rooms.[Room Category]
	from Reservations
	RIGHT JOIN Rooms
		ON Reservations.[Reservation ID] = Rooms.[Reservation ID]
GO

Select * from [RESERVATIONS VIEW]
----------------Reservation Final Table output for slip---------

---------------Check-Constraint------------------
alter table Reservations add constraint CKC_Reservations_IOS
check([Interval of Stay] IS NOT Null)

alter table Reservations add constraint CKC_Reservations_IOS_I
check([Interval of Stay] != 0 and [Interval of Stay] > 0)

alter table Reservations add constraint NOT_ZERO_CKC_Reservations_IOS
check([Interval of Stay] != 0)

alter table Customers add constraint NOT_ZERO_CKC_Customers_NOP
check([No. of Peoples] IS NOT NULL and [No. of Peoples] != 0)

alter table Customers add constraint NOT_ZERO_CKC_Customers_NOP_I
check([No. of Peoples] > 0)
---------------Check-Constraint------------------


--------------Cascade-Referential-Integrity-----------
--------------ON-CUSTOMER-ID's-----------
alter table [Customer's Phone No.s] add constraint CRI_FK_customer_id
foreign key ([Customer ID]) references [Customers]([Customer ID])on delete cascade

alter table [Payments] add constraint CRI_ON_PAYMENTS_FK_CUSTOMER_ID
foreign key ([Customer ID]) references [Customers]([Customer ID])on delete cascade

alter table [Reservations] add constraint CRI_ON_RESERVATIONS_FK_CUSTOMER_ID
foreign key ([Customer ID]) references [Customers]([Customer ID])on delete cascade

alter table [Transactions] add constraint CRI_ON_TRANSACTIONS_FK_CUSTOMER_ID
foreign key ([Customer ID]) references [Customers]([Customer ID])on delete cascade

alter table [Reviews] add constraint CRI_ON_REVIEWS_FK_CUSTOMER_ID
foreign key ([Customer ID]) references [Customers]([Customer ID])on delete cascade
--------------ON-CUSTOMER-ID's-----------


--------------ON-EMPLOYEE-ID's-----------
alter table [Employees Contact No.s] add constraint CRI_ON_EMPLOYEECONTACTNOS_FK_EMPLOYEE_ID
foreign key ([Employee ID]) references [Employees]([Employee ID])on delete cascade
--------------ON-EMPLOYEE-ID's-----------
--------------Cascade-Referential-Integrity-----------


--------------Stored-Procedure-Not-used-In-our-Database-Because-there-is-no-need-of-it-to-be-used------------------------
Create procedure spGetSpecificCustomerRecord
@No_of_Peoples int
as
begin
Select * from Customers where @No_of_Peoples = [No. of Peoples] and @No_of_Peoples >= 6
end

exec spGetSpecificCustomerRecord @No_of_Peoples = 7
--------------Stored-Procedure-Not-used-In-our-Database-Because-there-is-no-need-of-it-to-be-used------------------------


---------------------SQL-Triggers--------------------------------
SELECT*FROM Customers
insert into Customers values('Shahmeer','Khan','Shah Faisal',3)
insert into Customers values('Shaheer','Shakeel','Landhi',7)

create trigger tr_customers
on Customers
after insert as
begin
select * from inserted
end
---------------------SQL-Triggers--------------------------------

Select * from Rooms
Select * from Reservations
Select * from Transactions
Select * from Customers
Select * from Employees
Select * from Payments
insert into Reservations values (2, 10003, '5/18/2022', '5/20/2022', 4, 100)
insert into Employees values ('Bilal', 'Khattak', 'Bilal123', '1234', 'Manager', 'Karachi', 600000)
insert into Transactions values ('Reservation', 10003, 2000, '5/18/2022')
insert into Rooms values ('Economy', 3000)
insert into Payments values (10002, 3000, '5/18/2022', 4, 1)
insert into Payments values (10003, 3000, '5/18/2022', 6, 2)
alter table Payments add [No. of Days Stay] bigint
delete from Payments
delete from Reservations

Select * from [TRANSACTIONS VIEW]
Select * from [RESERVATIONS VIEW]

Select * from [CUSTOMERS VIEW]