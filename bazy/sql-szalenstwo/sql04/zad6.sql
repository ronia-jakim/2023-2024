INSERT INTO salary 
SELECT salary_from_b2b :: DECIMAL AS salary_from, 
      salary_to_b2b :: DECIMAL AS salary_to, 
      offer.id :: INTEGER AS offer_id,
      'b2b' AS type,
      offer.salary_currency_b2b :: TEXT AS currency
FROM offer 
WHERE
  offer.salary_from_b2b :: DECIMAL > 0 
  OR offer.salary_to_b2b :: DECIMAL > 0 
  OR offer.salary_currency_b2b != 'unknown'
