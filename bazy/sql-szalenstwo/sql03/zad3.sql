SELECT p_name, COALESCE(SUM(ps_availqty), 0)
FROM (
  SELECT ps_partkey, ps_availqty
  FROM region
    JOIN nation ON r_regionkey = n_regionkey
    JOIN supplier ON n_nationkey = s_nationkey
    JOIN partsupp ON s_suppkey = ps_suppkey
  WHERE 
    r_name = 'MIDDLE EAST'
  ) AS foo
  RIGHT JOIN part ON ps_partkey = p_partkey
WHERE 
  p_container = 'JUMBO PKG'
GROUP BY p_partkey
