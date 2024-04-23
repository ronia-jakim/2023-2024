SELECT DISTINCT company.name 
FROM company 
  JOIN offer ON company.id = offer.company_id 
WHERE
  offer.id NOT IN ( 
    SELECT offer.id 
    FROM offer 
      JOIN skill ON  offer.id = skill.offer_id 
      WHERE 
        skill.name ILIKE '%sql%' 
        OR skill.name ILIKE '%database%'
  )
ORDER BY company.name
