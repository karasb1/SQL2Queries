create database Hospital;
go
use Hospital;
go
create table Departments (
    id int primary key not null identity (1,1),
    Building int not null check (Building like '[0-5]'),
    Financing money not null check (Financing >= 0) default 0,
    Floor int not null check (Floor > 0),
    Name varchar(100) not null check (Name <> '') unique,
);
go
create table Diseases (
    Id int primary key not null identity (1,1),
    Name varchar(100) not null check (Name <> '') unique,
    Severity int not null check (Severity > 0) default 1,
)
go
create table Doctors (
    Id int primary key not null identity (1,1),
    Name varchar(max) not null check (Name like '[A-Z]%' and Name <> ''),
    Surname varchar(max) not null check (Surname like '[A-Z]%' and Surname <> ''),
    Phone char(10) not null check (Phone like '[0-9]%' and len(Phone) = 10),
    Premium money not null check (Premium >= 0) default 0,
    Salary money not null check (Salary > 0),
)
go
create table Examination (
    Id int primary key not null identity (1,1),
    DayOfWeek int not null check (DayOfWeek like '[1-7]'),
    StartTime time not null check (StartTime >= '08:00:00' and StartTime <= '18:00:00'),
    EndTime time not null,
    Name nvarchar(100) not null check (Name <> '' and Name like '[A-Z]%') unique,
    TimeValid as (case when EndTime > StartTime then 1 else 0 end) persisted,
    check (TimeValid = 1),
)
go
create table Wards (
    Id int primary key not null identity (1,1),
    Building int not null check (Building like '[0-5]'),
    Floor int not null check (Floor > 0),
    Name varchar(20) not null check (Name <> '' and Name like '[A-Z]') unique,
)
go


insert into Departments (Building, Financing, Floor, Name) values
(1, 10000, 1, 'Surgery'),
(2, 20000, 2, 'Therapy'),
(3, 30000, 3, 'Neurology'),
(4, 40000, 4, 'Cardiology'),
(5, 50000, 5, 'Oncology');
go
insert into Diseases (Name, Severity) values
('Flu', 1),
('Cancer', 5),
('Heart attack', 4),
('Stroke', 3),
('Pneumonia', 2);
go
insert into Doctors (Name, Surname, Phone, Premium, Salary) values
('John', 'Doe1', '1234567890', 100, 2000),
('Jane', 'Doe2', '1234567890', 200, 3000),
('Jack', 'Doe3', '1234567890', 300, 4000),
('Jill', 'Doe4', '1234567890', 400, 5000),
('Nancy', 'Doe5', '1234567890', 500, 6000);
go
insert into Examination (DayOfWeek, StartTime, EndTime, Name) values
(1, '08:00:00', '12:00:00', 'Blood test'),
(2, '08:00:00', '12:00:00', 'MRI'),
(3, '08:00:00', '12:00:00', 'CT'),
(4, '08:00:00', '12:00:00', 'X-ray'),
(5, '08:00:00', '12:00:00', 'Ultrasound');
go
insert into Wards (Building, Floor, Name) values
(1, 1, 'A'),
(2, 2, 'B'),
(3, 3, 'C'),
(4, 4, 'D'),
(5, 5, 'E');
go


select * from Wards;
select Surname, Phone from Doctors;
select distinct Floor from Wards;
select Name as 'Name of Disease', Severity as 'Severity of Disease' from Diseases;
select * from Departments as D, Diseases as Ds, Doctors as Dr;
select Name from Departments where Building = 5 and Financing < 30000;
select Name from Departments where Building = 3 and Financing between 12000 and 15000;
select Name from Wards where Building in (4, 5) and Floor = 1;
select Name, Building, Financing from Departments where Building in (3, 6) and (Financing < 11000 or Financing > 25000);
select Surname from Doctors where Salary + Premium > 1500;
select Surname from Doctors where Salary / 2 > Premium * 3;
select Name from Examination where StartTime between '12:00:00' and '15:00:00' and DayOfWeek in (1, 2, 3);
select Name, Building from Departments where Building in (1, 3, 8, 10);
select Name from Diseases where Severity not in (1, 2);
select Name from Departments where Building not in (1, 3);
select Name from Departments where Building in (1, 3);
select Surname from Doctors where Surname like 'N%';


drop table Departments;
drop table Diseases;
drop table Doctors;
drop table Examination;
drop table Wards;
drop database Hospital;