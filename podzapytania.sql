use Northwind
/*Æw.1	Wypisz nazwy produktów i ich ceny, ale tylko  tych  towarów, 
których cena jest  powy¿ej œredniej ceny wszystkich produktów. */

select ProductName, UnitPrice
from Products
where UnitPrice>
(
	select AVG(UnitPrice)from Products
)

--Æw.2	Wypisz nazwiko i imie  pracowników, którzy  realizuj¹ wiêcej zamówieñ ni¿ Davolio Nancy?

Select LastName, FirstName, COUNT(orders.OrderID)
from Employees join Orders on Employees.EmployeeID = Orders.EmployeeID
group by LastName, FirstName
having COUNT(orders.OrderID)>
(
	select COUNT(orders.OrderID)
	from Employees join Orders on Employees.EmployeeID = Orders.EmployeeID
	where FirstName like 'Nancy' and LastName like 'Davolio'
)

/*Æw.3	Podaj nazwisko i imiê oraz datê urodzenia najstarszego  pracownika (licz¹c rok urodzenia). 
Zadanie rozwi¹¿ dwoma sposobam z podzapytaniem i bez.*/

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

--Æw.4	Podaj imiona  i nazwiska pracownków których wiek przekracaz œredni wiek pracowników.

select FirstName, LastName, DATEDIFF(YEAR, BirthDate, getdate()) as wiek
from Employees
where DATEDIFF(YEAR, BirthDate, getdate()) >
(
	select AVG(DATEDIFF(YEAR, BirthDate, getdate()))
	from Employees
)

--Æw.5	Podaj nazwy firm które  s¹ z tego samego miasta co  klient Eastern Connection.

select Companyname
from Customers
where City =
(
	select City
	from Customers
	where CompanyName like 'Eastern Connection'
)

/*Æw.6	Wypisz  nazwy kategorii  produktów, których ³¹czna wartoœæ zamówieñ 
jest mniejsza ni¿ wartoœæ zamówieñ wszystkich napojów. ( Beverages)*/

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

--Æw.7	Wypisz te kraje w których znajduje siê wiêcej klientów  ni¿ w Meksyku.

select Country
from Customers
group by Country
having Count(CustomerID) >
(
	select count(CustomerID)
	from Customers 
	where Country like '%mexico%'
)

/*Æw.8	Podaj nazwy produktów, iloœæ w jakich by³y zamówione oraz œredni¹ cenê wszystkich produktów. 
Zestawienie ma obejmowaæ produkty zamówione w kwietniu 1997 roku. */

select Products.ProductName,sum([Order Details].Quantity) as 'iloœæ w zamówieniach',avg([Order Details].UnitPrice) as 'œrednia cena'
from [Order Details] join Products  on Products.ProductID = [Order Details].ProductID
					 join Orders on Orders.OrderID = [Order Details].OrderID
where month(orders.OrderDate)=4 and year(orders.orderDate)=1997
group by  Products.ProductName

--Æw.9	Podaj nazwê  kategorii  która ma najwiêcej produktów. Zadanie rozwi¹¿ dwoma sposobami. 

select top(1) Categories.CategoryName, count(Products.CategoryID)
from Categories join Products on Categories.CategoryID = Products.CategoryID
group by Categories.CategoryName
order by count(Products.CategoryID)desc

--Æw.10	Podaj nazwê firmy które dostarczaj¹ wiêcej produktów ni¿ firma Mayumi's. 

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

--Æw.11	Podaj nazwy wszystkich obszarów do których nie ma przypisanego ¿adnego pracownika. Zadanie rozwi¹¿  dwoma sposobami.

select Employees.FirstName,Employees.LastName,Region.RegionDescription
from Employees join EmployeeTerritories on Employees.EmployeeID = EmployeeTerritories.EmployeeID
			   join Territories on EmployeeTerritories.TerritoryID = Territories.TerritoryID
			   join Region on Territories.RegionID = Region.RegionID
group by Employees.FirstName,Employees.LastName,Region.RegionDescription

--Æw.12	Podaj klientów którzy nie z³o¿yli ¿adnego zamówienia. Zadanie rozwi¹¿ dwoma sposobami.

select *
from Customers left join Orders on Customers.CustomerID = Orders.CustomerID
where Orders.CustomerID is null

--Æw.13	Ilu kilentów kupi³o wiêcej ni¿ 30 ró¿nych produktów.

select  Customers.CompanyName,count(Customers.CustomerID)
from Orders join Customers on Orders.CustomerID = Customers.CustomerID
			join [Order Details] on Orders.OrderID = [Order Details].OrderID
where 30<(select sum([Order Details].Quantity) from [Order Details])
group by Customers.CompanyName
