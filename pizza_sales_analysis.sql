CREATE schema pizza_sales;

ALTER TABLE orders
RENAME COLUMN `date` TO datename;

# How is the monthly performance of pizza sales?
SELECT
  MONTHNAME(o.datename) AS `Month`,
  COUNT(od.order_id) AS `Count Order`,
  SUM(p.price * od.quantity) AS `Revenue`
FROM
  pizza_sales.orders AS o
  LEFT JOIN Pizza_sales.order_details AS od ON o.order_id = od.order_id
  LEFT JOIN Pizza_sales.pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY
  MONTHNAME(o.datename)
ORDER BY
  COUNT(od.order_id) DESC;
  
# Day of the week performance of pizza sales
SELECT
	DAYNAME(o.datename) as `Day of the week`,
	COUNT(o.datename) as `Count Order`,
    SUM(p.price * od.quantity) as `Revenue`
FROM 
	pizza_sales.orders as o
	LEFT JOIN pizza_sales.order_details as od
		ON o.order_id = od.order_id
	LEFT JOIN pizza_sales.pizzas as p
		ON od.pizza_id = p.pizza_id
GROUP BY
	DAYNAME(o.datename)
ORDER BY
	COUNT(od.order_id) DESC;
    
    # Now let's check the daily performance of pizza sales
SELECT
	DAY(o.datename) as `Day of the week`,
	COUNT(o.datename) as `Count Order`,
    SUM(p.price * od.quantity) as `Revenue`
FROM 
	pizza_sales.orders as o
	LEFT JOIN pizza_sales.order_details as od
		ON o.order_id = od.order_id
	LEFT JOIN pizza_sales.pizzas as p
		ON od.pizza_id = p.pizza_id
GROUP BY
	DAY(o.datename)
ORDER BY
	COUNT(od.order_id) DESC;
    
    # What hour has the most orders?

SELECT
	HOUR(o.time) as `Time`,
	COUNT(od.order_id) as `Count Order`,
    SUM(p.price * od.quantity) as `Revenue`
FROM 
	pizza_sales.orders as o
	LEFT JOIN pizza_sales.order_details as od
		ON o.order_id = od.order_id
	LEFT JOIN pizza_sales.pizzas as p
		ON od.pizza_id = p.pizza_id
GROUP BY
	HOUR(o.time)
ORDER BY
	COUNT(od.order_id) DESC;

# Checking the most ordered pizza

ALTER TABLE pizza_types
RENAME COLUMN `name` TO pizza_name;
    
SELECT 
	pt.pizza_name AS `Pizza names`,
	COUNT(od.order_id) as `Count Pizza`,
    SUM(p.price * od.quantity) AS Revenue
FROM 
	pizza_sales.order_details as od
	LEFT JOIN pizza_sales.pizzas as p
		ON od.pizza_id = p.pizza_id
	LEFT JOIN pizza_sales.pizza_types as pt
		ON p.pizza_type_id = pt.pizza_type_id
GROUP BY
	pt.pizza_name
ORDER BY
	COUNT(od.order_id) DESC;