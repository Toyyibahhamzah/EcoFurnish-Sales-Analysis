--List all products available in the inventory.
SELECT * FROM dimproduct;

--Find the total number of customers in the database.
SELECT COUNT (*) AS TotalCustomers FROM dimcustomer;

SELECT COUNT (customerid) AS TotalCustomers FROM dimcustomer;

--Display distinct categories of products sold.
SELECT * FROM dimproduct;
SELECT DISTINCT category FROM dimproduct;

--Identify customers who signed up in 2023.
SELECT * FROM dimcustomer;
SELECT firstname, lastname, signupyear, signupdate FROM dimcustomer WHERE signupyear = 2023;

SELECT firstname, lastname, signupyear, signupdate FROM dimcustomer WHERE signupyear = 2022;

--List products priced above $500.
SELECT productid, productname, price
FROM dimproduct WHERE price > 500;

--List products that are priced between 200 and 500
SELECT productid, productname, price
FROM dimproduct WHERE price between 200 and 500;

--Show products with less than 50 items in stock.
SELECT * from dimproduct where stockquantity < 50;

--List all sales transactions.
select * from factsales;

--Count the total number of sales transactions.
select count (*) as Totalsales from factsales;

--Display the top 10 most expensive products.
select * from dimproduct
order by price desc
limit 10;

--Find the average sale amount per transaction.
SELECT ROUND (AVG(saleamount),2) AS average_sale_amount
FROM factsales;

--Calculate the total revenue generated from sales.
SELECT ROUND (SUM(saleamount),2) AS totalrevenue
FROM factsales;

--Round the average price of the products to 2 decimal places.
select round (avg(price),2)
from dimproduct;

--List customer emails that contain 'gmail'.
SELECT * FROM dimcustomer;

--Determine the average sale amount for each product category.
SELECT ROUND(AVG(f.saleamount),2) AS Avg_sales_amount,dp.category
from factsales f
inner join dimproduct dp on f.productid = dp.productid
GROUP by dp.category
ORDER BY Avg_sales_amount DESC;


SELECT ROUND(AVG(factsales.saleamount),2) AS Avg_sales_amount,dimproduct.category
from dimproduct
inner join factsales on dimproduct.productid = factsales.productid
GROUP by dimproduct.category
ORDER BY Avg_sales_amount DESC;


--List customers and their purchase counts who have bought more than 3 items.
SELECT dc.firstname, dc.lastname, 
COUNT(f.saleid) AS Qty_Purchased
from dimcustomer dc
inner join factsales f ON f.customerid = dc.customerid
GROUP BY dc.customerid
HAVING COUNT(f.saleid) > 3


--List all products and any sales data, including products that have not been sold.
SELECT dp.productname, f.saleid, f.saleamount
from dimproduct dp
full outer join factsales f on dp.productid = f.productid;


--Show all customers and any sales transactions, including customers with no purchases.
SELECT dc.firstname, dc.lastname, f.saleid, f.saleamount
from dimcustomer dc
full join factsales f on f.customerid = dc.customerid;


--Find total sales and stock quantities for all products, including those never sold.
SELECT dp.productname, dp.stockquantity, sum(f.quantitysold) AS Total_sales 
from dimproduct dp
full join factsales f ON f.productid = dp.productid
group by dp.productname, dp.stockquantity
order by dp.stockquantity desc;

--List all sales transactions and match them with product information, including sales with unlisted products.
SELECT f.saleid, dp.productname
from factsales f
FULL outer join dimproduct dp on dp.productid = f.productid

SELECT f.saleid, dp.productname
from dimproduct dp
left join factsales f on dp.productid = f.productid

--Loyal custmers who have made at least 5 purchases in the past year
select customerid,sum (quantitysold) as Totalquantity_sold,
sum(saleamount) as TotalSpend from factsales 
where saledate between '2023-01-01' and '2023-12-31'
group by customerid,quantitysold
having sum(quantitysold) >=5
order by TotalSpend desc
LIMIT 5;


--Top 10 Product Categories for promotional campaign based on profitability:
select Productid, sum(SaleAmount) AS TotalSales
from FactSales
group by Productid
order by TotalSales desc
limit 10;