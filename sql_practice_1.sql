--- create 1st table
CREATE TABLE sales_overview (
	product_id INT PRIMARY KEY
	,products VARCHAR(30)
	,sales INT
);

--- create 2nd table
CREATE TABLE product_perf (
	months VARCHAR(15)
	,title VARCHAR(40)
	,product_id INT FOREIGN KEY REFERENCES sales_overview(product_id)
);

--- insert records into 1st table
INSERT INTO sales_overview VALUES (1,'Smartphones',250);
INSERT INTO sales_overview VALUES (2,'Speakers',110);
INSERT INTO sales_overview VALUES (3,'Speakers',90);
INSERT INTO sales_overview VALUES (4,'Headphones',210);
INSERT INTO sales_overview VALUES (5,'Tablets',280);
INSERT INTO sales_overview VALUES (6,'Smartphones',300);
INSERT INTO sales_overview VALUES (7,'Tablets',190);
INSERT INTO sales_overview VALUES (8,'Batteries',180);
INSERT INTO sales_overview VALUES (9,'Speakers',85);
INSERT INTO sales_overview VALUES (10,'Headphones',20);
INSERT INTO sales_overview VALUES (11,'Laptops',410);
INSERT INTO sales_overview VALUES (12,'Smartphones',120);

--- insert records into 2nd table
INSERT INTO product_perf VALUES('April','Best-seller',1);
INSERT INTO product_perf VALUES('April','Most returned',2);
INSERT INTO product_perf VALUES('April','Most returned',7);
INSERT INTO product_perf VALUES('May','Worst-seller',11);
INSERT INTO product_perf VALUES('May','Best-seller',6);
INSERT INTO product_perf VALUES('April','Best-seller',7);
INSERT INTO product_perf VALUES('June','Out of stock',3);
INSERT INTO product_perf VALUES('May','Out of stock',10);
INSERT INTO product_perf VALUES('June','New arrival',8);
INSERT INTO product_perf VALUES('June','Best-seller',12);
INSERT INTO product_perf VALUES('June','Out of stock',5);
INSERT INTO product_perf VALUES('June','New arrival',11);
INSERT INTO product_perf VALUES('May','Worst-seller',9);
INSERT INTO product_perf VALUES('May','Best-seller',12);
INSERT INTO product_perf VALUES('April','Worst-seller',11);

--- Q1:
--- What is the highest sales by each product?
SELECT 
	products
	,MAX(sales) AS bestsellers 
FROM sales_overview
GROUP BY products;

--- Q2:
--- Of all 3 best-sellers in the 2nd table, how many times did each of them get the title in April?
SELECT 
     product_perf.product_id
     ,c.products
     ,COUNT(*) AS num_of_tits
FROM product_perf
JOIN (
	SELECT 
		a.product_id
		,a.products
		,a.sales
	FROM sales_overview a
	JOIN (
		SELECT 
			products
			,MAX(sales) AS max_sales
		FROM sales_overview
		GROUP BY products
	) b
	ON a.products = b.products
	AND a.sales = b.max_sales
) c
ON product_perf.product_id = c.product_id
WHERE product_perf.months = 'April'
GROUP BY 
     c.products, 
     product_perf.product_id
ORDER BY c.products;

