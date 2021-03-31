use northwind;
select * from products;
select * from OrderDetails;

------*** exists, any will remove duplicated records ----------------

-- join --
select distinct companyName
from suppliers
join products
on suppliers.supplierID = products.supplierID
where products.UnitPrice < 20
order by companyName;
-- result: 39; with distinct: 24

---- where exsits ----
---- select .. from .. where exists (...);
select companyName
from suppliers
where exists (select productName from products where products.supplierID = suppliers.supplierID and unitprice < 20)
order by companyName;
-- result: 24
-- productName replaced by any other column, it still works

---- ANY, ALL ----
---- select ... from ... where ...= ANY (select .. from .. where..)
/*
used with a WHERE or HAVING clause
The ANY operator returns true if ANY of the subquery values meet the condition.
The ALL operator returns true if ALL of the subquery values meet the condition.
*/
SELECT ProductName 
FROM Products
WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity = 55)
order by ProductName; 
-- result: 8 rows

select productName, p.ProductID
from products p
join OrderDetails od
on p.productID = od.ProductID
where od.Quantity = 55
order by ProductName;
-- result: 9 rows (2 rows have same productName)

select * from orderdetails where quantity = 55 order by productID; 
-- result: 9 rows (2 rows have same productID)

SELECT ProductName 
FROM Products
WHERE exists (SELECT ProductID FROM OrderDetails WHERE Quantity = 55); 
-- result: 77 rows

SELECT ProductName 
FROM Products
WHERE ProductID = ALL (SELECT ProductID FROM OrderDetails WHERE Quantity > 0); 
