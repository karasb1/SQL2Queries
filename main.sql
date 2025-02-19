create database Academy
go
use Academy
go

create table Departments
(
    DepartmentId int primary key not null identity(1,1),
    DepartmentFinancing money not null check(DepartmentFinancing >= 0) default 0,
    DepartmentName nvarchar(50) not null unique check(DepartmentName != '' and DepartmentName like '[A-Z]%'),
)
go
create table Faculties
(
    FacultiesId int primary key not null identity(1,1),
    FacultiesDean nvarchar(max) not null check(FacultiesDean != '' and FacultiesDean like '[A-Z]%'),
    FacultiesName nvarchar(100) not null unique check(FacultiesName != '' and FacultiesName like '[A-Z]%'),
)
go
create table Groups
(
    GroupId int primary key not null identity(1,1),
    GroupName nvarchar(10) not null unique check(GroupName != '' and GroupName like '[A-Z]%'),
    GroupRating int not null check(GroupRating like '[0-5]'),
    GroupYear int not null check(GroupYear like '[1-5]'),
)
go
create table Teachers
(
    TeachersId int primary key not null identity(1,1),
    TeachersEmploymentDate date not null check(TeachersEmploymentDate >= '1990-01-01'),
    TeachersIsAssistant bit not null default 0,
    TeachersIsProfessor bit not null default 0,
    TeachersName nvarchar(max) not null check(TeachersName != '' and TeachersName like '[A-Z]%'),
    TeachersPosition nvarchar(max) not null check(TeachersPosition != '' and TeachersPosition like '[A-Z]%'),
    TeachersPremium money not null check(TeachersPremium >= 0) default 0,
    TeachersSalary money not null check(TeachersSalary >= 0),
    TeachersSurname nvarchar(max) not null check(TeachersSurname != '' and TeachersSurname like '[A-Z]%'),
)
go


insert into Departments(DepartmentFinancing, DepartmentName) values
(1000000, 'Mathematics'),
(2000000, 'Physics'),
(3000000, 'Chemistry'),
(4000000, 'Biology'),
(5000000, 'Computer Science'),
(6000000, 'Economics'),
(7000000, 'Philosophy'),
(8000000, 'History'),
(9000000, 'Geography'),
(10000000, 'Literature');
go
insert into Faculties(FacultiesDean, FacultiesName) values
('John Doe', 'Mathematics'),
('Jane Doe', 'Physics'),
('John Smith', 'Chemistry'),
('Jane Smith', 'Biology'),
('John Johnson', 'Computer Science'),
('Jane Johnson', 'Economics'),
('John Brown', 'Philosophy'),
('Jane Brown', 'History'),
('John White', 'Geography'),
('Jane White', 'Literature');
go
insert into Groups(GroupName, GroupRating, GroupYear) values
('A1', 5, 1),
('A2', 4, 2),
('A3', 3, 3),
('A4', 2, 4),
('A5', 1, 5);
go
insert into Teachers(TeachersEmploymentDate, TeachersIsAssistant, TeachersIsProfessor, TeachersName, TeachersPosition, TeachersPremium, TeachersSalary, TeachersSurname) values
('1990-01-01', 0, 1, 'John', 'Professor', 1000, 5000, 'Doe'),
('1990-01-01', 1, 0, 'Jane', 'Assistant', 500, 3000, 'Doe'),
('1990-01-01', 0, 1, 'John', 'Professor', 1000, 5000, 'Smith'),
('1990-01-01', 1, 0, 'Jane', 'Assistant', 500, 3000, 'Smith'),
('1990-01-01', 0, 1, 'John', 'Professor', 1000, 5000, 'Johnson'),
('1990-01-01', 1, 0, 'Jane', 'Assistant', 500, 3000, 'Johnson'),
('1990-01-01', 0, 1, 'John', 'Professor', 1000, 5000, 'Brown'),
('1990-01-01', 1, 0, 'Jane', 'Assistant', 500, 3000, 'Brown'),
('1990-01-01', 0, 1, 'John', 'Professor', 1000, 5000, 'White'),
('1990-01-01', 1, 0, 'Jane', 'Assistant', 500, 3000, 'White');
go

select DepartmentName, DepartmentFinancing, DepartmentId from Departments;
select GroupName as 'Group Name', GroupRating as 'Group Rating' from Groups;
select TeachersSurname, TeachersPremium * 100 / TeachersSalary as 'Premium %', TeachersSalary * 100 / (TeachersSalary + TeachersPremium) as 'Salary %' from Teachers;
select 'The dean of faculty ' + FacultiesName + ' is ' + FacultiesDean from Faculties;
select TeachersSurname from Teachers where TeachersIsProfessor = 1 and TeachersSalary > 1050;
select DepartmentName from Departments where DepartmentFinancing < 11000 or DepartmentFinancing > 25000;
select FacultiesName from Faculties where FacultiesName != 'Computer Science';
select TeachersSurname, TeachersPosition from Teachers where TeachersIsProfessor = 0;
select TeachersSurname, TeachersPremium from Teachers where TeachersPremium >= 160 and TeachersPremium <= 550;
select TeachersSurname, TeachersSalary from Teachers where TeachersPosition = 'Assistant';
select TeachersSurname, TeachersPosition from Teachers where TeachersEmploymentDate < '2000-01-01';
select DepartmentName as 'Name of Department' from Departments where DepartmentName < 'Software Development';
select TeachersSurname from Teachers where TeachersSalary + TeachersPremium <= 1200;
select GroupName from Groups where GroupYear = 5 and GroupRating >= 2 and GroupRating <= 4;
select TeachersSurname from Teachers where TeachersPosition = 'Assistant' and TeachersPremium < 200 or TeachersSalary < 550;

drop table Teachers;
drop table Groups;
drop table Faculties;
drop table Departments;
drop database Academy;