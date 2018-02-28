/*£¹czenie tabel – baza Northwind*/
use Northwind

/*Æw.1 Wypisz nazwy produktów miêsnych.*/
select ProductName, CategoryName
from Products join Categories
on Products.CategoryID = Categories.CategoryID
where CategoryName like '%Meat%'

/*Æw.2 Wypisz nazwy produktów wraz z nazw¹ firmy dostarczaj¹cej podukt. WeŸ pod uwagê tylko firmy japoñskie.*/
select ProductName, CompanyName
from Products join Suppliers
on Products.SupplierID=Suppliers.SupplierID
where Country like 'Japan'

/*Æw.3 Wypisz nazwy produktów, ich kategoriê oraz nazwê firmy dostarczaj¹cej towar. 
WeŸ pod uwagê tylko owoce morza i firmy japoñskie.*/
select ProductName, CategoryName, CompanyName
from Products join Categories
on Products.CategoryID=Categories.CategoryID
join Suppliers
on Products.SupplierID=Suppliers.SupplierID
where CategoryName like '%seafood%' and Country like 'Japan'

/*Æw.4 Wypisz dane zamówieñ: numer, nazwê klienta, imiê i nazwisko pracownika realizuj¹cego zamówienie, 
nazwê spedytora oraz datê zamówienia. Dane posortuj wed³ug klienta, a póŸniej wed³ug pracownika.*/
select OrderID, Customers.CompanyName as Klient, FirstName+' '+LastName as Pracownik, Shippers.CompanyName, OrderDate
from Orders join Customers
on Orders.CustomerID=Customers.CustomerID
join Employees
on Orders.EmployeeID=Employees.EmployeeID
join Shippers
on Orders.ShipVia=Shippers.ShipperID
order by Klient, Pracownik

/*Æw.5 Wypisz nazwiska i imiona tych pracowników, którzy obs³uguj¹ regiony: Boston, Orlando i Santa Cruz. 
Dane posortuj alfabetycznie.*/
select FirstName, LastName
From Employees join EmployeeTerritories
on Employees.EmployeeID=EmployeeTerritories.EmployeeID
join Territories
on EmployeeTerritories.TerritoryID=Territories.TerritoryID
where TerritoryDescription in ('Boston','Orlando','Santa Cruz')

/*Æw.6 Wypisz nazwy i adresy tych klientów, których dane znajduj¹ sie w bazie, ale nie dokonali jeszcze ¿adnego zamówienia.*/
select CompanyName, Address
from Customers left join Orders
on Customers.CustomerID=Orders.CustomerID
where Orders.CustomerID is null

/*Æw.7 Wypisz nazwy produktów, ich kategorie i ceny. WeŸ pod uwagê tylko 5 najdro¿szych produktów.*/
select top(5) with ties ProductName, CategoryName, UnitPrice
from Products join Categories on Products.CategoryID=Categories.CategoryID
order by UnitPrice desc

/*Æw.8 Wypisz te produkty, które maj¹ najwiêkszy rabat. Posortuj je alfabetycznie i nie dopuœæ do powtórzeñ nazw produktów.*/
select distinct top(1) with ties ProductName, Discount
from Products join [Order Details]
on Products.ProductID=[Order Details].ProductID
order by Discount desc 

/*Æw.9 Wypisz imiona i nazwiska pracowników ³¹cznie z danymi ich szefów.*/
select Pracownik.FirstName+' '+Pracownik.LastName as 'Dane pracownika', Szef.FirstName +' '+ Szef.LastName as 'Dane szefa'
from Employees Pracownik join Employees Szef
on Pracownik.ReportsTo = Szef.EmployeeID

/*Æw.10 Wypisz imiona i nazwiska pracowników ³¹cznie z danymi ich szefów. 
WeŸ pod uwagê równie¿ tych pracowników którzy nie maj¹ szefa.*/
select Pracownik.FirstName+' '+Pracownik.LastName as 'Dane pracownika', Szef.FirstName +' '+ Szef.LastName as 'Dane szefa'
from Employees Pracownik left join Employees Szef
on Pracownik.ReportsTo = Szef.EmployeeID
