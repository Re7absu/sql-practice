/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?
SELECT sales.customer_id ,SUM(menu.price) AS total_amount
FROM dannys_diner.sales JOIN dannys_diner.menu 
ON sales.product_id = menu.product_id
GROUP BY customer_id;

-- 2. How many days has each customer visited the restaurant?
SELECT sales.customer_id , count(DISTINCT order_date) AS Number_of_visits
FROM dannys_diner.sales
GROUP BY customer_id;

-- 3. What was the first item from the menu purchased by each customer?
SELECT product_name, customer_id 
FROM (
	SELECT m.product_name, s.customer_id,
	ROW_NUMBER() OVER (
		PARTITION BY s.customer_id
  		ORDER BY s.order_date ASC
	) AS first_item
 	FROM dannys_diner.menu AS m JOIN dannys_diner.sales AS s
  	ON m.product_id = s.product_id
)AS ranked_orders
WHERE first_item = 1 ;
    
 
-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT m.product_name , count(s.product_id) AS purchase_count 
FROM dannys_diner.menu AS m JOIN dannys_diner.sales AS s
	ON m.product_id = s.product_id
GROUP BY s.product_id , m.product_name
ORDER BY purchase_count DESC LIMIT 1;

-- 5. Which item was the most popular for each customer?
SELECT product_name , customer_id
FROM ( 
  SELECT m.product_name , s.customer_id, COUNT(s.product_id) purchase_count , 
      RANK() OVER(PARTITION BY customer_id ORDER BY COUNT(s.product_id) DESC) AS item_rank
      FROM dannys_diner.menu AS m JOIN dannys_diner.sales AS s 
      	ON m.product_id = s.product_id
      GROUP BY m.product_name , s.product_id , s.customer_id) AS order_rank
WHERE item_rank= 1 ;

-- 6. Which item was purchased first by the customer after they became a member?
WITH ranked_orders AS ( SELECT s.customer_id , m.product_name , ROW_NUMBER() OVER( PARTITION BY s.customer_id ORDER BY s.order_date )AS purchase_rank FROM dannys_diner.sales AS s JOIN dannys_diner.menu AS m ON s.product_id = m.product_id JOIN dannys_diner.members AS mb ON mb.customer_id = s.customer_id
WHERE order_date > join_date)
SELECT customer_id , product_name FROM ranked_orders
WHERE purchase_rank = 1; 

-- 7. Which item was purchased just before the customer became a member?
WITH ranked_orders AS ( SELECT s.customer_id , m.product_name , ROW_NUMBER() OVER( PARTITION BY s.customer_id ORDER BY s.order_date DESC )AS purchase_rank FROM dannys_diner.sales AS s JOIN dannys_diner.menu AS m ON s.product_id = m.product_id JOIN dannys_diner.members AS mb ON mb.customer_id = s.customer_id
WHERE order_date < join_date)
SELECT customer_id , product_name FROM ranked_orders
WHERE purchase_rank = 1 ;

-- 8. What is the total items and amount spent for each member before they became a member?

SELECT s.customer_id ,COUNT(s.product_id) AS total_items, SUM(m.price) AS amount 
FROM dannys_diner.sales AS s JOIN dannys_diner.menu AS m 
ON s.product_id = m.product_id JOIN dannys_diner.members AS mb ON s.customer_id = mb.customer_id
WHERE s.order_date < mb.join_date
GROUP BY s.customer_id;


-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

SELECT s.customer_id , 
SUM(
	CASE 
  		WHEN m.product_name = 'sushi' THEN m.price*20 
    	ELSE m.price*10 
    END ) AS points
FROM dannys_diner.sales AS s JOIN dannys_diner.menu AS m 
	ON s.product_id = m.product_id 
GROUP BY s.customer_id;



-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
SELECT s.customer_id , SUM( 
  CASE 
  	WHEN s.order_date BETWEEN mb.join_date AND mb.join_date + INTERVAL '6 days' 	then m.price*20 
 	WHEN m.product_name = 'sushi' THEN m.price*20 
 	ELSE m.price*10
  END ) AS january_points
  FROM dannys_diner.sales AS s JOIN dannys_diner.menu AS m ON s.product_id = m.product_id JOIN dannys_diner.members AS mb ON mb.customer_id = s.customer_id 
  WHERE s.customer_id IN ('A', 'B')  AND s.order_date <= '2021-01-31'
  GROUP BY s.customer_id ;







