/* CLASS WORK */

CREATE TABLE	dept1(
				deptId int not null primary key,
				deptName varchar(50) unique,
				description varchar(50))

CREATE TABLE	reportingManager(
				managerId int not null primary key Identity(10,1),
				name varchar(50),
				startDate datetime Default (getdate()))

CREATE TABLE	employee(
				employeeId int not null primary key,
				empName varchar(50) not null,
				location varchar(50),
				deptId int not null foreign key references dept1(deptId),
				managerId int not null foreign key references reportingManager(managerId),
				startDate date default(getDate()))