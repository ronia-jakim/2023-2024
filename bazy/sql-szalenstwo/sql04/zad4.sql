SELECT company.name, 
offer.title, 
offer.experience_level, 
offer.salary_from_b2b :: DECIMAL, 
offer.salary_to_b2b :: DECIMAL, 
ROUND(offer.salary_to_b2b :: DECIMAL - offer.salary_from_b2b :: DECIMAL) AS diff, 
ROUND(100 * (offer.salary_to_b2b :: DECIMAL - salary_from_b2b :: DECIMAL) / offer.salary_from_b2b :: DECIMAL) AS perc
FROM company 
  JOIN offer ON company.id = offer.company_id
WHERE 
  offer.salary_from_b2b :: DECIMAL > 0
  AND offer.published_at :: DATE >= '22.04.2023'
  AND offer.salary_currency_b2b = 'pln'
ORDER BY perc, company.name ASC
