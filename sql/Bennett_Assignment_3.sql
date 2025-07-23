Select * from transactions_log
LIMIT 5;

select count(orderreturned) as order_returned_count, deliveryzipcode 
from transactions_log
where orderreturned = 'Yes'
Group by deliveryzipcode
ORDER BY order_returned_count DESC
LIMIT 5;

Select count(orderid) as order_count, category, deliveryzipcode
from transactions_log
Group by category, deliveryzipcode
ORDER BY deliveryzipcode;

Select deliveryzipcode,
ROUND(Sum(sales::NUMERIC), 2) as Total_Sales
from transactions_log
where orderreturned = 'No'
Group by deliveryzipcode
ORDER BY Total_Sales DESC;


CREATE TABLE q4_data AS 
Select deliveryzipcode,
category,
sales
from transactions_log
WHERE orderreturned = 'No'
AND (deliveryzipcode IN ('75284', '37237', '75236', '33172', '33231'))
AND (category IN ('Appliances', 'Furnishings', 'Phones', 'Golf', 'Machines'))
Limit 1000;

Create table q5_df AS
select EXTRACT(MONTH from purchasedate) as Sale_Month,
category,
deliveryzipcode,
count(*) as Total_Sales_Count
from transactions_log
Group by category, deliveryzipcode, Sale_Month
ORDER BY deliveryzipcode, category, Total_Sales_Count
Limit 12;


CREATE TABLE q6 AS
Select COUNT(transactions_log.actualdeliverydate - transactions_log.expecteddeliverydate) AS total_delayed_deliveries,
logistics_supply_chain_network.distribution_center_id,
logistics_supply_chain_network.city
from transactions_log
inner join logistics_supply_chain_network
ON transactions_log.deliveryzipcode = logistics_supply_chain_network.zipcode
WHERE orderreturned = 'No'
Group by distribution_center_id, city
ORDER BY total_delayed_deliveries DESC
limit 10;

Select customerid,
firstname,
lastname,
productid,
rating,
array_length(string_to_array(sharedwith, ';'), 1) AS share_count,
array_length(string_to_array(friends, ';'), 1) as friends_count
from transactions_log
WHERE rating IN (1, 5)
ORDER BY sharedwith DESC, friends DESC
LIMIT 5;



Select transactions_log.deliveryzipcode,
logistics_supply_chain_network.distribution_center_id,
logistics_supply_chain_network.city,
transactions_log.sales
from transactions_log
inner join logistics_supply_chain_network
ON transactions_log.deliveryzipcode = logistics_supply_chain_network.zipcode
WHERE orderreturned = 'No' 
AND logistics_supply_chain_network.city ='Miami'
OR logistics_supply_chain_network.city ='Atlanta'
Group by logistics_supply_chain_network.city, logistics_supply_chain_network.distribution_center_id, transactions_log.deliveryzipcode, transactions_log.sales
ORDER BY transactions_log.sales DESC
limit 20;


SELECT 
  delivery_dow,
  AVG(sale_count) AS avg_sales_per_zip
FROM (
  SELECT 
    EXTRACT(DOW FROM actualdeliverydate) AS delivery_dow,
    deliveryzipcode,
    COUNT(*) AS sale_count
  FROM transactions_log
  GROUP BY delivery_dow, deliveryzipcode
) AS sub
GROUP BY delivery_dow
ORDER BY delivery_dow;


create table q9 as 
select EXTRACT(DOW from actualdeliverydate) as Delivery_dow,
deliveryzipcode,
Count(sales) as Sale_Count
from transactions_log
Group by Delivery_dow, deliveryzipcode
Order by Sale_Count DESC;

select Delivery_dow, 
deliveryzipcode,
Round(AVG(Sale_Count), 0) as avg_del_count
from q9
Group by Delivery_dow, deliveryzipcode
Order by avg_del_count DESC
LIMIT 25;

