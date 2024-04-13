SELECT * 
FROM customer
  LEFT JOIN nation ON c_nationkey = n_nationkey
