SELECT c_name, sum(o_totalprice)
FROM (
  SELECT c_name, c_custkey
  FROM customer
       JOIN nation ON c_nationkey = n_nationkey
       JOIN region ON n_regionkey = r_regionkey 
  WHERE 
    r_name = 'EUROPE'
)
JOIN orders ON c_custkey = o_custkey 
WHERE 
  EXTRACT(YEAR from o_orderdate) = 1997 
GROUP BY c_name
HAVING sum(o_totalprice) >= 500000
