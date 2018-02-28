create database Muzyka
use Muzyka

create table Panstwa
(
	Id_Panstwa varchar(3) primary key
	check(Id_Panstwa not like '%[0-9]%'),
	Nazwa varchar(20) not null,
)

insert into Panstwa
values 
('PL', 'Polska'), 
('USA', 'Stany Zjednoczone'),
('IR', 'Irlandia'), 
('FR', 'Francja'), 
('GB', 'Wielka Brytania')

create table Wykonawcy
(
	Id_Wykonawcy varchar(3) primary key 
	check(Id_Wykonawcy like '[A-Z][0-9][0-9]'),
	Nazwisko varchar(25),
	Imie varchar(10),
	Pseudonim varchar(10),
	Pochodzenie varchar(3) not null foreign key references Panstwa(Id_Panstwa) on update cascade
)
insert into Wykonawcy
values
('W01',NULL, NULL, 'U2','IR'),
('W02','Kowalska','Kasia',NULL,'PL'),
('W03','Davis','Miles',NULL,'USA')

create table Muzyka_Rodzaje
(
	Id_Rodzaju varchar(3) primary key,
	Rodzaj varchar(10) not null
)
insert into Muzyka_Rodzaje
values
('J','Jazz'),
('R','Rock'),
('P','Pop')

create table Plyty
(
	Id_Plyty varchar(5) primary key
	check(Id_plyty like '[A-Z][0-9][0-9][0-9][0-9]'),
	Tutul varchar(35) not null,
	Rok int 
	check(Rok>1950),
	Id_Rodzaju varchar(3) not null foreign key references Muzyka_Rodzaje(Id_Rodzaju)
)

insert into Plyty
values
('P0001','Seven steps to heaven','1963','J'),
('P0002','Love songs','1999','J'),
('P0003','Achtung Baby',NULL,'R')

create table Plyty_Wykonawcy
(
	Id_Plyty varchar(5) foreign key references Plyty(Id_Plyty)
	check(Id_plyty like '[A-Z][0-9][0-9][0-9][0-9]'),
	Id_Wykonawcy varchar(3) foreign key references Wykonawcy(Id_Wykonawcy)
	check(Id_Wykonawcy like '[A-Z][0-9][0-9]'),
	constraint PK primary key (Id_Plyty, Id_Wykonawcy)
)
insert into Wykonawcy
values
('W04','Fitzgerald','Ella',NULL,'USA'),
('W05','Armstrong','Louis',NULL,'USA')

insert into Plyty
values
('P0004','Ella i Louis Again','2003','J')

insert into Plyty_Wykonawcy
values
('P0004','W04'),
('P0004','W05')

alter table Wykonawcy
	add KTO char
	check (KTO like '[k,m,z]')

update Wykonawcy
set KTO = 'Z'
where Imie is null

update Wykonawcy
set KTO = 'K'
where imie like '%a'

update Wykonawcy
set KTO = 'M'
where imie not like '%a'

select * from Wykonawcy

alter table Plyty
	add Cena money 
	check(Cena>0)