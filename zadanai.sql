--Æwiczenia do bazy: NorthWind
use Northwind
--Æw.1	Wypisz imiona i nazwiska wszystkich pracowników.
select FirstName, LastName
from Employees
--Æw.2	Wypisz imiona i nazwiska wszystkich pracowników, któych nazwiska zaczynaj¹ siê na litere D.
select FirstName, LastName
from Employees
where LastName like 'D%'
--Æw.3	Wypisz imiona, nazwiska oraz dok³adne adresy wszystkich pracowników zatrudnionych w Stanach Zjednoczonych.
select FirstName, LastName, Address
from Employees
where Country like 'USA'
--Æw.4	W tabeli wynikowej z  æw.3 kolumny powinny mieæ  polskie nazwy (aliasy).
select FirstName as Imiê, LastName as Nazwisko, Address as Adres
from Employees
where Country like 'USA'
--Æw.5	Wypisz nazwiska, imiona oraz stanowiska pracowników.
select FirstName, LastName, Title
from Employees
--Æw.6	Wypisz nazwiska, imiona osób zatrudnionych na stanowisku "Sales Representative".
select FirstName, LastName, Title
from Employees
where Title like 'Sales Representative'
--Æw.7	Wypisz dane tych pracowników, którzy nie maj¹ przypisanego szefa.
select *
from Employees
where ReportsTo is null
--Æw.8	Wypisz nazwiska, imiona oraz rok urodzenia pracowników. Dane posortuj wed³ug roku urodzenia.
select FirstName, LastName, year(BirthDate) as 'Rok urodzenia'
from Employees
order by year(BirthDate) asc
--Æw.9	Wypisz nazwiska, imiona oraz wiek  pracowników. 
--Dane posortuj wed³ug wieku, tak by osoby najstarsze by³y wypisane jako pierwsze, 
--nastêpnym kryterium sortowania powinno byæ nazwisko.
select FirstName, LastName, DATEDIFF(YEAR,BirthDate,GETDATE()) as Wiek
from Employees
order by DATEDIFF(YEAR,BirthDate,GETDATE()) desc, LastName
--Æw.10	Wypisz nazwiska, imiona oraz iloœæ przepracowanych lat, pracowników najd³u¿ej zatrudnionych, 
--w firmie NothWind.
select top(1) with ties FirstName, LastName, DATEDIFF(year,HireDate,GETDATE()) as 'Przepraowane lata'
from Employees
order by DATEDIFF(year,HireDate,GETDATE()) desc
--Æw.11	Wypisz  nazwiska pracowników pochodz¹cych z Seattle i nazwiska osób pochodz¹cych z Redmond.
select LastName
from Employees
where City like 'Seattle' or City like 'Redmond'
--Æw.12	Wypisz  nazwiska pracowników o identyfikatorach: 2,6,7,9.
select LastName
from Employees
where EmployeeID in (2,6,7,9)
--Æw.13	Wypisz  nazwiska pracowników o identyfikatorach miêdzy 2 i 8.
select LastName
from Employees
where EmployeeID between 2 and 8
--Æw.14	Wypisz wszystkie dane dostawców z Niemiec i z Japonii
Select *
from Suppliers
where Country in ('Germany','Japan')
--Æw.15	Wypisz nazwy i adresy dostawców – spó³ek z ograniczona odpowiedzialnoœci¹ (Ltd).
Select CompanyName, Address
from Suppliers
where CompanyName like '%Ltd.%'
--Æw.16	Wypisz dane (Nazwy, Jednostki w jakich s¹ sprzedawane oraz ceny) tych produktów, 
--które w nazwie maj¹ s³owo „Camembert” .
select ProductName, QuantityPerUnit, UnitPrice
from Products
where ProductName like '%Camembert%'
--Æw.17	Wypisz dane (Nazwy, Jednostki w jakich s¹ sprzedawane oraz ceny) tych produktów, 
--które  sprzedawane s¹ w s³oikach lub w butelkach (bottles, jars). Dane posortuj wed³ug ceny, 
--tak by najdro¿sze wyœwietlone by³y jako pierwsze.
select ProductName, QuantityPerUnit, UnitPrice
from Products
where QuantityPerUnit like'%bottles%' or QuantityPerUnit like '%jars%'
--Æw.18	Wypisz dane (nazwy, jednostki w jakich s¹ sprzedawane oraz ceny) tych produktów, 
--których cena jest miêdzy 10 a 20 (³¹cznie z cenami:10 i 20).
select ProductName, QuantityPerUnit, UnitPrice
from Products
where UnitPrice between 10 and 20
--Æw.19	Wypisz dane (nazwy, jednostki w jakich s¹ sprzedawane oraz ceny) tych produktów, 
--których nazwy zaczynaj¹ siê na jedn¹ z liter: C, K i P oraz sprzedawane s¹ w paczkach.
select ProductName, QuantityPerUnit, UnitPrice
from Products
where ProductName like '[C,K,P]%' and QuantityPerUnit like '%box%'
--Æw.20	Wypisz wszystkie dane tych produktów, których nazwy nie zaczynaj¹ sie na ¿adn¹ z liter: 
--A, G, N i S oraz ich cena jest z przedzia³u zamknietego <15;20>. Dane posortuj wed³ug cen, 
--tak by jako pierwsze by³y  najdro¿sze podukty.
select *
from Products
where ProductName not like '[A, G, N, S]%' and UnitPrice between 15 and 20
order by UnitPrice desc
--Æw.21	Wypisz nazwy i ceny jednostkowe tych produktów, których nazwa jest czteroliterowa.
select ProductName, UnitPrice
from Products
where ProductName like '____'