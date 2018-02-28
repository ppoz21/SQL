/*��czenie tabel � baza Northwind*/
use Northwind

/*�w.1 Wypisz nazwy produkt�w mi�snych.*/
select ProductName, CategoryName
from Products join Categories
on Products.CategoryID = Categories.CategoryID
where CategoryName like '%Meat%'

/*�w.2 Wypisz nazwy produkt�w wraz z nazw� firmy dostarczaj�cej podukt. We� pod uwag� tylko firmy japo�skie.*/
select ProductName, CompanyName
from Products join Suppliers
on Products.SupplierID=Suppliers.SupplierID
where Country like 'Japan'

/*�w.3 Wypisz nazwy produkt�w, ich kategori� oraz nazw� firmy dostarczaj�cej towar. 
We� pod uwag� tylko owoce morza i firmy japo�skie.*/
select ProductName, CategoryName, CompanyName
from Products join Categories
on Products.CategoryID=Categories.CategoryID
join Suppliers
on Products.SupplierID=Suppliers.SupplierID
where CategoryName like '%seafood%' and Country like 'Japan'

/*�w.4 Wypisz dane zam�wie�: numer, nazw� klienta, imi� i nazwisko pracownika realizuj�cego zam�wienie, 
nazw� spedytora oraz dat� zam�wienia. Dane posortuj wed�ug klienta, a p�niej wed�ug pracownika.*/
select OrderID, Customers.CompanyName as Klient, FirstName+' '+LastName as Pracownik, Shippers.CompanyName, OrderDate
from Orders join Customers
on Orders.CustomerID=Customers.CustomerID
join Employees
on Orders.EmployeeID=Employees.EmployeeID
join Shippers
on Orders.ShipVia=Shippers.ShipperID
order by Klient, Pracownik

/*�w.5 Wypisz nazwiska i imiona tych pracownik�w, kt�rzy obs�uguj� regiony: Boston, Orlando i Santa Cruz. 
Dane posortuj alfabetycznie.*/
select FirstName, LastName
From Employees join EmployeeTerritories
on Employees.EmployeeID=EmployeeTerritories.EmployeeID
join Territories
on EmployeeTerritories.TerritoryID=Territories.TerritoryID
where TerritoryDescription in ('Boston','Orlando','Santa Cruz')

/*�w.6 Wypisz nazwy i adresy tych klient�w, kt�rych dane znajduj� sie w bazie, ale nie dokonali jeszcze �adnego zam�wienia.*/
select CompanyName, Address
from Customers left join Orders
on Customers.CustomerID=Orders.CustomerID
where Orders.CustomerID is null

/*�w.7 Wypisz nazwy produkt�w, ich kategorie i ceny. We� pod uwag� tylko 5 najdro�szych produkt�w.*/
select top(5) with ties ProductName, CategoryName, UnitPrice
from Products join Categories on Products.CategoryID=Categories.CategoryID
order by UnitPrice desc

/*�w.8 Wypisz te produkty, kt�re maj� najwi�kszy rabat. Posortuj je alfabetycznie i nie dopu�� do powt�rze� nazw produkt�w.*/
select distinct top(1) with ties ProductName, Discount
from Products join [Order Details]
on Products.ProductID=[Order Details].ProductID
order by Discount desc 

/*�w.9 Wypisz imiona i nazwiska pracownik�w ��cznie z danymi ich szef�w.*/
select Pracownik.FirstName+' '+Pracownik.LastName as 'Dane pracownika', Szef.FirstName +' '+ Szef.LastName as 'Dane szefa'
from Employees Pracownik join Employees Szef
on Pracownik.ReportsTo = Szef.EmployeeID

/*�w.10 Wypisz imiona i nazwiska pracownik�w ��cznie z danymi ich szef�w. 
We� pod uwag� r�wnie� tych pracownik�w kt�rzy nie maj� szefa.*/
select Pracownik.FirstName+' '+Pracownik.LastName as 'Dane pracownika', Szef.FirstName +' '+ Szef.LastName as 'Dane szefa'
from Employees Pracownik left join Employees Szef
on Pracownik.ReportsTo = Szef.EmployeeID
