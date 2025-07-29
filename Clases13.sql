create table Customer(
Customer_ID varchar2 (20) primary key,
First_Name varchar2(20),
Order_Code char(50),
Last_Name VARCHAR2(50),
City VARCHAR2(50),
Phone_Number char(20));

drop table Customer

--table order
create table OrderProduct(
Order_Number primary key,
Customer_ID varchar2(20),
Costumer_Name varchar2(50),
City varchar2(50),
Shipment_Date Date,
Constraint fk_OrderProduct Foreign key (Costumer_ID) references Customer(Customer_ID));

Select * from OrderProduct

Create table Product (
Product_ID number primary key,
Quantily varchar2(50),
Product_type varchar2(50),
Order_Number number,
CONSTRAINT fk_Product Foreign key(Order_Number) references OrderProduct(Order_Number));

INSERT INTO Customer  VALUES ('C001', 'John', 'OC001', 'Doe', 'New York', '6677-8990');
INSERT INTO Customer  VALUES ('C002', 'Alice', 'OC002', 'Smith', 'Los Angeles', '8823-4455');
INSERT INTO Customer  VALUES ('C003', 'Bob', 'OC003', 'Johnson', 'Chicago', '7777-4567');
INSERT INTO Customer  VALUES ('C004', 'Emily', 'OC004', 'Brown', 'Houston', '8833-4566');
INSERT INTO Customer  VALUES ('C005', 'David', 'OC005', 'Lee', 'Seattle', '6544-5666');

INSERT INTO OrderProduct VALUES (1001, 'C001', 'John Doe', 'New York', TO_DATE('2024-04-17', 'YYYY-MM-DD'));
INSERT INTO OrderProduct VALUES (1002, 'C002', 'Alice Smith', 'Los Angeles', TO_DATE('2024-04-18', 'YYYY-MM-DD'));
INSERT INTO OrderProduct VALUES (1003, 'C003', 'Bob Johnson', 'Chicago', TO_DATE('2024-04-19', 'YYYY-MM-DD'));
INSERT INTO OrderProduct VALUES (1004, 'C004', 'Emily Brown', 'Houston', TO_DATE('2024-04-20', 'YYYY-MM-DD'));
INSERT INTO OrderProduct VALUES (1005, 'C005', 'David Lee', 'Seattle', TO_DATE('2024-04-21', 'YYYY-MM-DD'));

INSERT INTO Product VALUES (2001, '10', 'Electronics', 1001);
INSERT INTO Product VALUES (2002, '5', 'Clothing', 1002);
INSERT INTO Product VALUES (2003, '8', 'Home Appliances', 1003);
INSERT INTO Product VALUES (2004, '15', 'Books', 1004);
INSERT INTO Product VALUES (2005, '12', 'Toys', 1005);

--Realizar una consulta para obtener nombre completo de los clientesque incluya la ciudad y numero de telefono
select First_Name || ' ' || Last_Name As Full_Name,City,Phone_Number
From Customer;

--Realiazar una consulta que muestre los nombres de los clientes que han realizado pedidos
select DISTINCT C.First_Name
from Customer C
Join OrderProduct  o on c.Customer_ID=o.Customer_ID

--Realizar una consulta para obtener el total de pedidos realizados por cada cliente
select c.First_Name,count(o.Order_Number) as Total_Orders
from Customer C
left Join OrderProduct o on c.Customer_ID=o.Customer_ID
group by c.First_Name;

--realizar una consulta que muestre los productos vendidos junto con la cantidad y el tipo de producto
select p.Product_ID,p.Quantily,p.Product_Type
from Product p
JOIN OrderProduct o on p.Order_Number=o.Order_Number;

--Realizar consulta con el nombre del cliente que pidio mas reciente
select c.First_Name,Max(c.Shipment_Date) as Latest_Shipment
from Costumer c
join OrderProduct   o on c.Customer_ID=o.Customer_ID
group by c.First_Name
order by Latest_Shipment DESC
FETCH FIRST 1 ROW ONLY;

--Clientes que no realizaron pedidos
select c.Customer_ID,c.First_Name
from Customer c
Left JOIN OrderProduct o on c.Customer_ID=o.Customer_ID
where o.Order_Number is null;

--Cantidad de productos vendidos por tipo
select Product_Type,sum(Quantity) as Total_Sold
from Product
group by Product_Type;

--clientes que han realizado pedidos en mas de una ciudad
select c.Customer_ID,c.First_Name || ' ' || c.Last_Name as Customer_Name
from OrderProduct o
join Customer c on o.Customer_ID=c.Customer_ID
group by c.Customer_ID,c.First_Name,c.Last_Name
having count(distinct o.City)>1;

--Actualizar campo
Update OrderProduct set City='Houston' where Order_Number=1004

Update OrderProduct set Customer_ID='c001' where Order_Number=1004

Update OrderProduct set Custumer_Name='John Doe' where Order_Number=1004

select * from OrderProduct

--cantidad de ventas por ciudad
select o.City, sum(TO_NUMBER(p.Quantity)) as Total_Sales
from OrderProduct  o
Join Product p  on o.Order_Number=p.Order_Number
group by o.City;

--calcular el promedio de cantidad de productos por tipo de productos
select p.Product_Type, AVG(TO_NUMBER(p.Quantity)) as Total_Sales
from Product p
group by p.Product_Type;

--ordenar la fecha de envio mas reciente a la mas envia
select c.First_Name || ' ' || c.Last_Name as Customer_Name,Max(o.Shipment_Date) as Latest_Shipment
from Customer o 
join OrderProduct o on o.Custmer_ID=o.Customer_ID
group by c.First_Name,c.Last_Name
order by Latest_Shipment desc;

--crear vista con informacion de pedidos
create view CustomerOrders as
select c.Customer_ID,c.First_Name || ' ' || c.Last_Name as Customer_Name,
o.Order_Number,o.City
from Customer c
join OrderProduct o on c.Customer_ID=o.Customer_ID;
select * from CustomerOrders;
