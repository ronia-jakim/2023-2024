SELECT DISTINCT o_orderkey, o_orderdate, o_orderpriority 
FROM orders 
  JOIN lineitem ON o_orderkey = l_orderkey
WHERE 
  l_shipdate > o_orderdate + 120
  AND ( o_orderpriority LIKE '1-%' OR o_orderpriority LIKE '2-%')
  AND EXTRACT(MONTH from o_orderdate) = 8
ORDER BY o_orderpriority, o_orderdate, o_orderkey ASC
