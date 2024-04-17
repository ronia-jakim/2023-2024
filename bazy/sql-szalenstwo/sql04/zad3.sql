SELECT DISTINCT company.name
FROM company 
  JOIN offer ON company.id = company_id
  JOIN skill ON offer.id = offer_id
WHERE
  skill.name LIKE '%PostgreSQL%'
  OR skill.name ILIKE '%postres%'
