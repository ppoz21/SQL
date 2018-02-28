use Northwind
/*�w.1	Wypisz nazwy produkt�w i ich ceny, ale tylko  tych  towar�w, 
kt�rych cena jest  powy�ej �redniej ceny wszystkich produkt�w. */

select ProductName, UnitPrice
from Products
where UnitPrice>
(
	select AVG(UnitPrice)from Products
)

--�w.2	Wypisz nazwiko i imie  pracownik�w, kt�rzy  realizuj� wi�cej zam�wie� ni� Davolio Nancy?

Select LastName, FirstName, COUNT(orders.OrderID)
from Employees join Orders on Employees.EmployeeID = Orders.EmployeeID
group by LastName, FirstName
having COUNT(orders.OrderID)>
(
	select COUNT(orders.OrderID)
	from Employees join Orders on Employees.EmployeeID = Orders.EmployeeID
	where FirstName like 'Nancy' and LastName like 'Davolio'
)

/*�w.3	Podaj nazwisko i imi� oraz dat� urodzenia najstarszego  pracownika (licz�c rok urodzenia). 
Zadanie rozwi�� dwoma sposobam z podzapytaniem i bez.*/

/*wersja 1 bez podzapytania*/

select top(1) with ties FirstName, LastName, BirthDate
from Employees
order by BirthDate

/*wersja 2 bez podzapytania*/

select top(1) with ties FirstName, LastName, year(GETDATE())-YEAR(BirthDate)
from Employees
order by year(GETDATE())-YEAR(BirthDate) desc

/*Wersja z podzapytaniem*/

select FirstName, LastName, BirthDate
from Employees
where year(GETDATE())-YEAR(BirthDate) =
(
	select top(1) with ties year(GETDATE())-YEAR(BirthDate)
	from Employees
	order by year(GETDATE())-YEAR(BirthDate) desc
)

--�w.4	Podaj imiona  i nazwiska pracownk�w kt�rych wiek przekracaz �redni wiek pracownik�w.

select FirstName, LastName, DATEDIFF(YEAR, BirthDate, getdate()) as wiek
from Employees
where DATEDIFF(YEAR, BirthDate, getdate()) >
(
	select AVG(DATEDIFF(YEAR, BirthDate, getdate()))
	from Employees
)

--�w.5	Podaj nazwy firm kt�re  s� z tego samego miasta co  klient Eastern Connection.

select Companyname
from Customers
where City =
(
	select City
	from Customers
	where CompanyName like 'Eastern Connection'
)

/*�w.6	Wypisz  nazwy kategorii  produkt�w, kt�rych ��czna warto�� zam�wie� 
jest mniejsza ni� warto�� zam�wie� wszystkich napoj�w. ( Beverages)*/

select CategoryName
from Categories join Products
on Categories.CategoryID = Products.ProductID
join [Order Details] 
on Products.ProductID = [Order Details].ProductID
group by CategoryName
HAVING sum([Order Details].UnitPrice*UnitsOnOrder) <
(
	select sum([Order Details].UnitPrice*Quantity)
	from Products join Categories
	on Categories.CategoryID = Products.CategoryID
	join [Order Details] 
	on Products.ProductID = [Order Details].ProductID
	where CategoryName like 'Beverages'
)

--�w.7	Wypisz te kraje w kt�rych znajduje si� wi�cej klient�w  ni� w Meksyku.

select Country
from Customers
group by Country
having Count(CustomerID) >
(
	select count(CustomerID)
	from Customers 
	where Country like '%mexico%'
)

/*�w.8	Podaj nazwy produkt�w, ilo�� w jakich by�y zam�wione oraz �redni� cen� wszystkich produkt�w. 
Zestawienie ma obejmowa� produkty zam�wione w kwietniu 1997 roku. */

select Products.ProductName,sum([Order Details].Quantity) as 'ilo�� w zam�wieniach',avg([Order Details].UnitPrice) as '�rednia cena'
from [Order Details] join Products  on Products.ProductID = [Order Details].ProductID
					 join Orders on Orders.OrderID = [Order Details].OrderID
where month(orders.OrderDate)=4 and year(orders.orderDate)=1997
group by  Products.ProductName

--�w.9	Podaj nazw�  kategorii  kt�ra ma najwi�cej produkt�w. Zadanie rozwi�� dwoma sposobami. 

select top(1) Categories.CategoryName, count(Products.CategoryID)
from Categories join Products on Categories.CategoryID = Products.CategoryID
group by Categories.CategoryName
order by count(Products.CategoryID)desc

--�w.10	Podaj nazw� firmy kt�re dostarczaj� wi�cej produkt�w ni� firma Mayumi's. 

select Suppliers.CompanyName
from Products join Suppliers on Products.SupplierID = Suppliers.SupplierID
group by Suppliers.CompanyName
having count(Products.SupplierID)
 > 
 (
 select count(Products.SupplierID)
 from Products join Suppliers on Products.SupplierID = Suppliers.SupplierID
 where Suppliers.CompanyName like 'Mayumi%'
 )

--�w.11	Podaj nazwy wszystkich obszar�w do kt�rych nie ma przypisanego �adnego pracownika. Zadanie rozwi��  dwoma sposobami.

select Employees.FirstName,Employees.LastName,Region.RegionDescription
from Employees join EmployeeTerritories on Employees.EmployeeID = EmployeeTerritories.EmployeeID
			   join Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID
			   join Region on Territories.RegionID = Region.RegionID
group by Employees.FirstName,Employees.LastName,Region.RegionDescription

--�w.12	Podaj klient�w kt�rzy nie z�o�yli �adnego zam�wienia. Zadanie rozwi�� dwoma sposobami.

select *
from Customers left join Orders on Customers.CustomerID = Orders.CustomerID
where Orders.CustomerID is null

--�w.13	Ilu kilent�w kupi�o wi�cej ni� 30 r�nych produkt�w.

select  Customers.CompanyName,count(Customers.CustomerID)
from Orders join Customers on Orders.CustomerID = Customers.CustomerID
			join [Order Details] on Orders.OrderID = [Order Details].OrderID
where 30<(select sum([Order Details].Quantity) from [Order Details])
group by Customers.CompanyName
