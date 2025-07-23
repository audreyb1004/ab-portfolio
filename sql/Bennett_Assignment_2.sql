select reg_name, cus_code, sum(Total_Sold) from dwcust_reg_totals
GROUP BY cus_code, reg_name;

select reg_name, cus_code, sum(Total_Sold) from dwcust_reg_totals
GROUP BY ROLLUP (cus_code, reg_name);

select reg_name, cus_code, sum(Total_Sold) from dwcust_reg_totals
GROUP BY CUBE (cus_code, reg_name);


SELECT cus_code,
tm_month, 
p_code,
SUM(Total_Sold)
from dwcust_date_totals
WHERE Total_Sold IS NOT NULL
group by ROLLUP (cus_code, tm_month,p_code)
ORDER BY cus_code DESC;


SELECT cus_code,
tm_month,
MAX(cus_lname),
MAX(cus_fname),
SUM(sale_units * sale_price) AS Total_Sold
from dwsales_master1
WHERE tm_month=9
GROUP BY cus_code, tm_month
ORDER BY Total_Sold Desc;


SELECT tm_month,
p_category,
Total_Sales
from dwsales_master
ORDER BY tm_month, p_category Desc;

SELECT COUNT(Total_Sales) as Total_sales_count,
SUM(Total_Sales) as Total_sales_sum,
tm_month
from dwsales_master
Group BY (tm_month)
ORDER BY tm_month DESC;


SELECT p_category,
p_code,
p_descript, 
SUM(sale_units) AS total_units
from dwsales_master
GROUP by (p_category, p_code, p_descript)
ORDER by total_units DESC;

SELECT p_category,
p_code,
p_descript, 
SUM(sale_units) AS total_units
from dwsales_master
WHERE tm_month=9
GROUP by (p_category, p_code, p_descript)
ORDER by total_units DESC;


SELECT p_category,
p_code,
p_descript, 
SUM(sale_units) AS total_units
from dwsales_master
WHERE tm_month=10
GROUP by (p_category, p_code, p_descript)
ORDER by total_units DESC;

SELECT Count(sale_units) AS count_sales,
tm_month,
p_category,
p_descript,
total_sales
from dwsales_master
GROUP by (tm_month, p_category, p_descript, total_sales)
ORDER by tm_month, p_category, p_descript DESC;

SELECT SUM(total_sales) AS total_sales,
v_name
from dwsales_master
GROUP by v_name
ORDER by total_sales DESC
LIMIT 5;

SELECT p_code,
p_descript, 
p_category
from dwsales_master
WHERE tm_year != 2015;


SELECT 
p_descript,
reg_name,
sum(sale_units) AS total_units
from dwsales_master
GROUP BY p_descript, reg_name
ORDER BY total_units DESC, reg_name;


