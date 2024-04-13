SELECT n_name, max(ss)
FROM nation 
JOIN (SELECT c_nationkey, c_name, sum(o_totalprice) AS ss
FROM customer
  JOIN orders ON c_custkey = o_custkey
GROUP BY c_custkey) ON c_nationkey = n_nationkey
GROUP BY c_nationkey, n_name
