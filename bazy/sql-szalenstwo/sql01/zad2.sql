SELECT customer.* 
FROM customer JOIN nation ON customer.c_nationkey = nation.n_nationkey
WHERE 
  c_acctbal >= 9000
  AND c_mktsegment = 'BUILDING'
  AND n_name = 'UNITED STATES'
ORDER BY c_name DESC
