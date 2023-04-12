CREATE DATABASE IF NOT EXISTS dreamhome;
USE dreamhome;

DROP TABLE IF EXISTS branch;

CREATE TABLE branch
(branchNo char(5) PRIMARY KEY,
 street varchar(35),
 city varchar(10),
 postcode varchar(10)
);

INSERT INTO branch VALUES('B005','22 Deer Rd','London','SW1 4EH');
INSERT INTO branch VALUES('B007','16 Argyll St', 'Aberdeen','AB2 3SU');
INSERT INTO branch VALUES('B003','163 Main St', 'Glasgow','G11 9QX');
INSERT INTO branch VALUES('B004','32 Manse Rd', 'Bristol','BS99 1NZ');
INSERT INTO branch VALUES('B002','56 Clover Dr', 'London','NW10 6EU');

DROP TABLE if EXISTS staff;

CREATE TABLE staff
(staffNo char(5) PRIMARY KEY,
 fName varchar(10),
 lName varchar(10),
 position varchar(10),
 sex char(1),
 DOB date,
 salary int,
 branchNo char(5)
);
ALTER TABLE staff 
Add foreign key (branchNo) references branch( branchNo);

INSERT INTO staff VALUES('SL21','John','White','Manager','M','1965-10-01',30000,'B005');
INSERT INTO staff VALUES('SG37','Ann','Beech','Assistant','F','1980-11-10',12000,'B003');
INSERT INTO staff VALUES('SG14','David','Ford','Supervisor','M','1978-03-24',18000,'B003');
INSERT INTO staff VALUES('SA9','Mary','Howe','Assistant','F','1990-02-19',9000,'B007');
INSERT INTO staff VALUES('SG5','Susan','Brand','Manager','F','1960-06-03',24000,'B003');
INSERT INTO staff VALUES('SL41','Julie','Lee','Assistant','F','1985-06-13',9000,'B005');

DROP TABLE IF EXISTS privateOwner;
CREATE TABLE privateOwner
(ownerNo char(5) PRIMARY KEY,
 fName varchar(10),
 lName varchar(10),
 address varchar(50),
 telNo char(15),
 email varchar(50),
 password varchar(40)
);

INSERT INTO privateOwner VALUES('CO46','Joe','Keogh','2 Fergus Dr. Aberdeen AB2 ','01224-861212', 'jkeogh@lhh.com', null);
INSERT INTO privateOwner VALUES('CO87','Carol','Farrel','6 Achray St. Glasgow G32 9DX','0141-357-7419', 'cfarrel@gmail.com', null);
INSERT INTO privateOwner VALUES('CO40','Tina','Murphy','63 Well St. Glasgow G42','0141-943-1728', 'tinam@hotmail.com', null);
INSERT INTO privateOwner VALUES('CO93','Tony','Shaw','12 Park Pl. Glasgow G4 0QR','0141-225-7025', 'tony.shaw@ark.com', null);

DROP TABLE IF EXISTS propertyForRent;
CREATE TABLE propertyForRent
(propertyNo char(5) PRIMARY KEY,
 street varchar(35),
 city varchar(10),
 postcode varchar(10),
 type varchar(10),
 rooms smallint,
 rent int,
 ownerNo char(5) not null,
 staffNo char(5),
 branchNo char(5)
);

INSERT INTO propertyForRent VALUES('PA14','16 Holhead','Aberdeen','AB7 5SU','House',6,650,'CO46','SA9','B007');
INSERT INTO propertyForRent VALUES('PL94','6 Argyll St','London','NW2','Flat',4,400,'CO87','SL41','B005' );
INSERT INTO propertyForRent VALUES('PG4','6 Lawrence St','Glasgow','G11 9QX','Flat',3,350,'CO40', NULL, 'B003');
INSERT INTO propertyForRent VALUES('PG36','2 Manor Rd','Glasgow','G32 4QX','Flat',3,375,'CO93','SG37','B003' );
INSERT INTO propertyForRent VALUES('PG21','18 Dale Rd','Glasgow','G12','House',5,600,'CO87','SG37','B003');
INSERT INTO propertyForRent VALUES('PG16','5 Novar Dr','Glasgow','G12 9AX','Flat',4,450,'CO93','SG14','B003' );

DROP TABLE IF EXISTS client;
CREATE TABLE client
(clientNo char(5) PRIMARY KEY,
 fName varchar(10),
 lName varchar(10),
 telNo char(15),
 prefType varchar(10),
 maxRent int,
 email varchar(50)
);

INSERT INTO client VALUES('CR76','John','Kay','0171-774-5632','Flat',425, 'john.kay@gmail.com');
INSERT INTO client VALUES('CR56','Aline','Steward','0141-848-1825','Flat',350, 'astewart@hotmail.com');
INSERT INTO client VALUES('CR74','Mike','Ritchie','01475-943-1728','House',750, 'mritchie@yahoo.co.uk');
INSERT INTO client VALUES('CR62','Mary','Tregear','01224-196720','Flat',600, 'maryt@hotmail.co.uk');

DROP TABLE IF EXISTS viewing;
CREATE TABLE  viewing
(clientNo char(5) not null,
 propertyNo char(5) not null,
 viewDate date,
 comment varchar(15)
);
INSERT INTO viewing VALUES('CR56','PA14','2015-05-24','too small');
INSERT INTO viewing VALUES('CR76','PG4','2015-04-20','too remote');
INSERT INTO viewing VALUES('CR56','PG4','2015-05-26','');
INSERT INTO viewing VALUES('CR62','PA14','2015-05-14','no dining room');
INSERT INTO viewing VALUES('CR56','PG36','2015-04-28','');

DROP TABLE IF EXISTS registration;
CREATE TABLE registration
(clientNo char(5) not null,
 branchNo char(5) not null,
 staffNo char(5) not null,
 dateJoined date
);

INSERT INTO registration VALUES('CR76','B005','SL41','2015-01-13');
INSERT INTO registration VALUES('CR56','B003','SG37','2014-04-13');
INSERT INTO registration VALUES('CR74','B003','SG37','2013-11-16');
INSERT INTO registration VALUES('CR62','B007','SA9','2014-03-07');

drop table lease;
create table lease
(leaseId int primary key,
clientNo varchar(30) ,
Rent int,
Deposit Boolean,
paymentMethod varchar(30),
propertyNo varchar(30),
rentStartDt varchar(20),
rentEndDt varchar(20),
DurationInYears float,
FOREIGN KEY (propertyNo) references propertyforrent(propertyNo));

SET FOREIGN_KEY_CHECKS=0;

insert into lease values (1,'CR56',450,TRUE,'cash','PG4','01/06/2004','31/05/2005',1);
insert into lease values (2,'CR74',950,TRUE,'cheque','PA14','01/03/2003','31/04/2006',3);

show tables;
select * from branch;
select * from client;
select * from privateowner;
select * from propertyforrent;
select * from registration;
select * from staff;
select * from viewing;
select * from lease;

-- queries to be executed --
-- a 
select * from branch where city = 'London';

-- b
select count(branchNo)as numofbranches from branch group by city;

-- c
select fName,position,salary from staff where branchNo = 'B003' order by fName;

-- d
select count(staffNo) as numofemp,sum(salary) as tot_sal from staff group by branchNo;

-- e
select count(staffNo) as numofemp from staff as s,branch as b where s.branchNo = b.branchNo and city = 'Glasgow' group by position;

-- f
select s.fName,s.branchNo
from staff s,branch b
where s.branchNo = b.branchNo
order by b.city;

-- g
select fName 
from staff 
where branchNo in (select branchNo 
				   from staff
                   where position = 'supervisor');
                   
-- h
select propertyNo , street,city , type , rent
from propertyforrent
where city = 'Glasgow'
order by rent;

-- i
select * from propertyforrent
where staffNo is not null;

-- j
select count(staffNo),branchNo
from propertyforrent
order by branchNo;

-- k
select * from propertyforrent
where ownerNo in (select ownerNo from privateowner)
order by branchNo;

-- l
select count(type) 
from propertyforrent
order by branchNo;

-- m
select * from privateowner 
where ownerNo in (
select ownerNo 
from propertyforrent
group by ownerNo  
having count(*)>1);

-- n
select * from propertyforrent
where type = 'Flat' and propertyNo in ( select propertyNo from propertyforrent
										where rooms > 3 and rent <500 and city = 'Aberdeen');

-- o
select c.clientNo ,c.fName , c.telNo , c.prefType 
from client c , registration r
where r.clientNo = c.clientNo
order by r.branchNo;

-- p


-- q
select * from lease 
where rentEndDt LIKE '31_04%';

-- r
select * from lease
where DurationInYears <1 and propertyNo in (select propertyNo from propertyforrent where city = 'Aberdeen');

-- s

