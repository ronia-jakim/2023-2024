CREATE TABLE customers_no_orders (LIKE customer);

INSERT INTO customers_no_orders
SELECT customer.* 
FROM customer 
  LEFT JOIN orders ON c_custkey = o_custkey 
  WHERE o_orderkey IS NULL;

