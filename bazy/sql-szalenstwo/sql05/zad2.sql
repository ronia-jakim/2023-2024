WITH ordertotals AS (
SELECT c_nationkey, c_name, SUM(o_totalprice) AS total
FROM customer JOIN orders ON c_custkey = o_custkey
WHERE EXTRACT('YEAR' FROM o_orderdate) = 1997
GROUP BY c_custkey
)
SELECT n_name, c_name, total
FROM (SELECT c_nationkey, MAX(total) AS total
FROM ordertotals
GROUP BY c_nationkey
) AS foo
NATURAL JOIN ordertotals
RIGHT JOIN nation ON c_nationkey = n_nationkey
