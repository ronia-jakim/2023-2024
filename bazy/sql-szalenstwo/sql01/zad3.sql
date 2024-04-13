SELECT DISTINCT s_name
FROM supplier 
  JOIN lineitem ON s_suppkey = l_suppkey 
  JOIN part ON p_partkey = l_partkey 
  JOIN nation ON n_nationkey = s_nationkey
  JOIN region on r_regionkey = n_regionkey
WHERE 
  p_type LIKE '%BRUSHED BRASS'
  AND p_size = 50
  AND r_name = 'ASIA'
