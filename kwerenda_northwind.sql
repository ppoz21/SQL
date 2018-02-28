USE Northwind

SELECT companyname
FROM dbo.Customers
WHERE companyname LIKE '%Restaurant%'

SELECT CompanyName
FROM dbo.Customers
WHERE CompanyName LIKE 'B''s Beverages'

Select productid, productname, supplierid, unitprice
from products
where (ProductName like 'T%' or ProductID = 46) and (UnitPrice>16)

select firstname as imiê, LastName as nazwisko
from Employees
where ReportsTo is null