DROP DATABASE IF EXISTS Electricity_bill_management_system;

CREATE DATABASE Electricity_bill_management_system;

USE Electricity_bill_management_system;

CREATE TABLE Branch (
	branchId varchar (15),
	branchName varchar (50) not null,
	address varchar (100) not null unique	, 
	email varchar (75) unique not null, 
	city varchar (25) not null,
	phoneNumber varchar (15) unique not null,
	primary key (branchId)
);


CREATE TABLE Department (
	departId varchar (15),
	departmentName varchar (75) not null,
	startDate datetime default current_timestamp(),
	address varchar (100) not null,
	phoneNumber varchar (15) unique not null,
	email varchar (75) unique not null,
	primary key (departId)
);


CREATE TABLE Position (
 	positionId int auto_increment,
	positionName varchar (50) unique not null,
	description varchar(255),
	primary key (positionId)
);

CREATE TABLE Employee (
	employeeId varchar(15),
	departId varchar (15),
	branchId varchar(15),
	positionId int,
	fname varchar (25) not null,
	lname varchar (25),
	gender enum ("Female", "Male") not null,
	address varchar (75) not null unique,
	phoneNumber varchar (15) not null unique,
	date_of_birth date not null,
	email varchar (75) unique not null, 
	startDate datetime default current_timestamp(),
    salary double not null,
	primary key (employeeId),
	foreign key (departId) references Department (departId),
	foreign key (branchId) references Branch (branchId),
	foreign key (positionId) references Position (positionId)
);


CREATE TABLE Customer (
	customerId int auto_increment,
	fname varchar (25) not null,
	lname varchar (25),
	email varchar (75) unique,
	phoneNumber varchar (15) not null unique,
	address varchar (75),
	startDate datetime default current_timestamp(),
	facility_address varchar (50) not null unique,
	facility_pincode varchar (15),
	city varchar (25),
	primary key (customerId)
); 


CREATE TABLE Complaint (
	complaintId varchar(15),
	complaintDate datetime default current_timestamp(),
	description Varchar (255) not null,
	resolveDate date,
	primary key (complaintId)
);


CREATE TABLE Meter (
	meter_no varchar(15),
	customerId int,
	meterType enum ("Reading", "Credit") not null,
	installedDate datetime default current_timestamp(),
    bill_no varchar (15),
    consumption double not null,
	rateApplied float default 0.1,
	amountPaid double not null,
	billDate date not null,
	paidDate date,
	dueDate date not null,
	paymentMode varchar (25) not null,
	primary key (meter_no),
	foreign key (customerId) references Customer (customerId)
);


CREATE TABLE CustomerComplaint(
	CustomerId int, 
	ComplaintId varchar (15),
	FOREIGN KEY (customerId) REFERENCES Customer (customerId) on delete cascade,
	FOREIGN KEY (complaintId) REFERENCES Complaint (complaintId)
);


CREATE TABLE EmployeeComplaint (
	EmployeeId varchar(15), 
	ComplaintId varchar (15),
	FOREIGN KEY (employeeId) REFERENCES Employee (employeeId) on delete cascade,
	FOREIGN KEY (complaintId) REFERENCES Complaint (complaintId)
);


CREATE TABLE ResidentialCustomer (
	customerId int,
	low_energy_consump_level double,
	FOREIGN KEY (customerId) REFERENCES Customer (customerId)
);


CREATE TABLE NonResidentialCustomer(
	customerId int,
	medium_energy_consump_level double,
	FOREIGN KEY (customerId) REFERENCES Customer (customerId) on delete cascade
);


CREATE TABLE SpecialLoadTariff(
	customerId int,
	high_energy_consump_level double,
	FOREIGN KEY (customerId) REFERENCES Customer (customerId) on delete cascade
);

INSERT INTO Branch (branchId, branchName, address,  email,  city, phoneNumber)
VALUES ("NEDCo100", "Tamale branch", "P. O. Box 100 Tamale - Northern Region", "tamale.northen@nedco.gh", "Tamale", "+233-55000000"),
	   ("NEDCo200", "Wa branch", "P. O. Box 200 Wa – Upper West Region", "wa.upperwest@nedco.gh", "Wa","+233-54000111"),
	   ("NEDCo300", "Bolga branch", "P. O. Box 300 Bolga - Upper East Region", "bolga.upperweast@nedco.gh", "Bolga", "+233-550000222"),
	   ("NEDCo400", "Sunyani branch", "P. O. Box 400 Sunyani - Savannah Region", "sunyani.savannah@nedco.gh", "Sunyani", "+233-550000333"),
	   ("NEDCo500", "Techiman branch", "P. O. Box 500 Techiman - Bono East Region", "techiman.boneast@nedco.gh", "Techiman", "+233-550000444");

INSERT INTO Department (departId, departmentName, startDate, address, phoneNumber, email)
VALUES ("Dept_1",  "Technical Department", "2000-11-13", "DD1", "+233445508093", "dept1.technical@nedco.gh"),
	("Dept_2",  "Human Resource Department", "1991-12-02", "DD2", "+233745508223", "dept2.humanresource@nedco.gh" ),
	("Dept_3",  "Finance Department", "1997-10-04", "DD3", "+233438508093","dept2.finance@nedco.gh"),
	("Dept_4",  "Real Estate Department", "2002-11-09", "DD4", "+233445508293", "dept1.realestate@nedco.gh"),
	("Dept_5",  "Audit Department", "2000-1-06", "DD5", "+233547508093", "dept3.audit@nedco.gh");

INSERT INTO Position (positionName, description) 
VALUES ("Manager", "Manager manages a branch"),
	("Intern", "Works as a national service personnel"),
	("Worker", "Works on different tasks"),
	("HR", "recruits new employees"),
	("Board Member", "Participes in board meetings and makes decision for the company"),
	("Board Director", "Direct the resource of the company");


INSERT INTO Employee(employeeId, fname, lname, gender, address, phoneNumber, date_of_birth, email, startDate, salary, departId, branchId, positionId) 
VALUES ("Emp34802", "Richard", "Gbamara", "Male", "P.O.Box 14", "+233551732706", "1945-08-02", "richard.gbamara@gmail.com", "2000-05-21", 50000.00, "Dept_1", "NEDCo400", 3),
	("Emp55892", "Fatima", "Issifu", "Female", "P.O.Box 147", "+233557735706", "1955-09-08", "Fatima.issifu@gmail.com", "2010-11-25", 7000.00, "Dept_2", "NEDCo500", 4),
	("Emp88563", "Mubashir", "Halidu", "Male", "P.O.Box 1758", "+233551732569", "1950-07-17", "mubashir.halidu@gmail.com", "2005-04-25", 55000.00, "Dept_3", "NEDCo200", 1),
	("Emp56893", "Alberta", "Owusu", "Female", "P.O.Box 58", "+233558569856", "1965-05-12", "alberta.owusu@gmail.com", "2020-02-13", 12000.00, "Dept_4", "NEDCo300", 5),
	("Emp59852", "Sadiq", "Abubakari", "Male", "P.O.Box 758", "+233558965875", "1985-03-21", "sadiq.abubakari@gmail.com", "2003-10-26",  10000.00,"Dept_5", "NEDCo100", 2);


INSERT INTO Customer (fname, lname, email, phoneNumber, address, startDate, facility_address, facility_pincode, city)
VALUES ("Brian", "Peter", "brian.peter@gmail.gh", "+233-553342223", "Yoga estate, P. O. Box 41, Bono East Region", "2012-12-03", "NL388", "P1000", "Techiman"),
	 ("Meg", "Peterson", "meg.peterson@gmail.gh", "+233-503234233", "Sanfin estate, P. O. Box 09, Upper West Region", "2016-02-11", "KL360", "ZR453", "Wa"),
	 ("Leanne", "Frankson", "leanne.frankson@gmail.gh", "+233-553342013", "Duffie, P. O. Box 10, Tamale Region", "2017-10-17", "GH404", "YUR130", "Tamale"),
	 ("Adelle", "Hutchful", "adelle.hutchful@gmail.gh", "+233-2030411120", "Tanko, P. O. Box 32, Savannah Region", "2019-12-30", "RA435", "LK534", "Damongo"),
	 ("Nicole", "Amoanki", "nicole.amoanki@gmail.gh", "+233-550018023", "Oteng Koranchi, P. O. Box 39, Tamale Region", "2012-12-03", "AR100", "DE2010", "Tamale");


INSERT INTO Complaint(complaintId, complaintDate, description, resolveDate) 
VALUES  ("CP3080", "2012-03-20", "I have issues with over charging", "2012-03-21"),
		("CP2024", "2012-05-20", "I have issues with over charging", "2012-05-25"),
		("CP3489", "2013-07-20", "I have light out two days ago.", "2013-07-25"),
		("CP3036", "2014-05-20", "I high voltage of power for one week now", "2014-05-20"),
		("CP7020", "2016-05-20", "My meter is not working", "2012-05-21");


INSERT INTO Meter(meter_no, customerId, meterType, installedDate, bill_no, consumption, rateApplied, amountPaid, billDate, paidDate, dueDate, paymentMode)
VALUES  ("Mtr021", 4, "Credit", "2000-05-18", "367349", 203.42, 0.1, 234.50, "2021-12-06", null, "2022-12-12", "credit Card"),
("Mtr022", 2, "Reading", "2000-05-18", "503484", 607.44, 0.6, 500.00, "2021-01-07", "2022-01-07", "2022-12-12", "Cash"),
("Mtr023", 3, "Credit", "2015-10-15", "640745", 300.90, 0.5, 903.45, "2021-3-11", "2022-3-11", "2022-12-12", "Mobile Money"),
("Mtr024", 5, "Reading", "2018-08-21", "693845", 400.34, 0.3, 100.50, "2021-10-09", "2022-06-09", "2022-12-12", "Mobile money"),
("Mtr025", 1, "Credit", "2015-04-26", "992744", 245.90, 0.7, 342.56, "2021-8-01", "2022-08-01", "2022-12-12", "Cash");


INSERT INTO CustomerComplaint(CustomerId, ComplaintId) VALUES
(3, "CP2024"),
(2, "CP3489"),
(3, "CP3036"),
(3, "CP7020"),
(1, "CP3080"),
(2, "CP2024"),
(5, "CP3489"),
(4, "CP3036"),
(3, "CP7020"),
(1, "CP3080");


INSERT INTO EmployeeComplaint(employeeId, ComplaintId) VALUES
("Emp55892", "CP2024"),
("Emp34802", "CP3489"),
("Emp56893", "CP3036"),
("Emp56893", "CP7020"),
("Emp59852", "CP3080"),
("Emp59852", "CP2024"),
("Emp34802", "CP3489"),
("Emp56893", "CP3036"),
("Emp34802", "CP7020"),
("Emp56893", "CP3080");

INSERT INTO ResidentialCustomer (customerId, low_energy_consump_level)
VALUES  (4, 100.00),
		(3, 39.90),
		(1, 11.05),
		(5, 80.80),
		(2, 67.20);
        
        
INSERT INTO NonResidentialCustomer (customerId, medium_energy_consump_level)
VALUES (3, 500.00),
	(2, 700.00),
	(5, 800.00),
	(1, 670.00),
	(4, 1000.00);

INSERT INTO SpecialLoadTariff (customerId, high_energy_consump_level)
VALUES (1, 3500.00),
	(2, 4700.00),
	(3, 7800.00),
	(4, 10670.00),
	(5, 10000.00);

-- QUERY ONE
select 
	Employee.positionId,
	Employee.salary,
    Position.positionName
from Employee
inner join Position on Employee.positionId = Position.positionId
order by salary;

-- QUERY TWO        
select 
	Employee.fname,
    Position.positionName,
    Department.departmentName
from Employee
	inner join Position on Employee.positionId = Position.positionId
    inner join Department on Employee.departId = Department.departId;

-- QUERY THREE    
select 
	e.fname,
	e.departId
FROM Employee e
WHERE e.salary IN
    (SELECT max(salary)
     FROM Employee
     GROUP BY departId);
     
-- QUERY FOUR
select
	Customer.fname,
    Complaint.description
from CustomerComplaint
	inner join Customer on Customer.customerId=CustomerComplaint.CustomerId
    inner join Complaint on Complaint.ComplaintId=CustomerComplaint.ComplaintId;

-- QUERY FIVE
select count(description)  
from Complaint
where description = "I have issues with over charging";

select description, count(*)  
from Complaint group by description
order by count(*) desc;



select 
	Customer.fname,
	Customer.lname,
	Meter.consumption
from Meter
inner join Customer on Meter.customerId = Customer.customerId
where Meter.consumption < 300
order by Meter.consumption ASC;


-- QUERY SIX
select 
	Customer.customerId,
	Customer.fname, 
    Customer.lname,
    Customer.email,
    Customer.address,
    Meter.paidDate
from Meter
inner join Customer on Customer.customerId = Meter.customerId
where Meter.paidDate is null
order by Customer.customerId ASC;





