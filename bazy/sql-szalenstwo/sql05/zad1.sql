SELECT c_name, sum(o_totalprice)
  FROM customer 
    JOIN orders ON c_custkey = o_custkey
    JOIN nation ON c_nationkey = n_nationkey
    JOIN region ON n_regionkey = r_regionkey
  WHERE 
    r_name = 'EUROPE'
    AND EXTRACT(YEAR from o_orderdate) = 1997
  GROUP BY c_custkey
  HAVING sum(o_totalprice) > 500000
