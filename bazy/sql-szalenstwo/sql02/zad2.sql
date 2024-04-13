SELECT o_orderkey
FROM ( 
  SELECT o_orderkey, count(l_orderkey)
  FROM orders JOIN lineitem ON o_orderkey = l_orderkey
  GROUP BY o_orderkey
  HAVING count(l_orderkey) > 1
)
EXCEPT DISTINCT
SELECT o_orderkey
FROM (
  SELECT o_orderkey, count(l1.l_orderkey)
  FROM orders, lineitem l1, lineitem l2
  WHERE 
  o_orderkey = l1.l_orderkey 
  AND o_orderkey = l2.l_orderkey
  AND l1.l_shipmode != l2.l_shipmode
  GROUP BY o_orderkey, l1.l_shipmode, l2.l_shipmode
)
ORDER BY o_orderkey ASC
