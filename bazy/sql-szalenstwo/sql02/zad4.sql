SELECT c_custkey 
FROM customer
EXCEPT DISTINCT
SELECT c_custkey 
FROM 
  (
    SELECT c_custkey, count(o_custkey)
    FROM customer
       JOIN orders ON c_custkey = o_custkey
    GROUP BY c_custkey,o_orderkey
    HAVING count(*) >= 1
  )
ORDER BY c_custkey ASC
