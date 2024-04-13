UPDATE customer
SET c_acctbal = 1.1 * c_acctbal
FROM (
  SELECT c_custkey, r_name
  FROM customer 
     JOIN nation ON c_nationkey = n_nationkey
     JOIN region ON n_regionkey = r_regionkey) region
WHERE 
  region.r_name = 'EUROPE' 
  AND region.c_custkey = customer.c_custkey
