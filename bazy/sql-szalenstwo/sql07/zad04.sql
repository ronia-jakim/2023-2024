SELECT DISTINCT company.name 
FROM company 
WHERE 
  company.id NOT IN ( 
    SELECT company.id 
    FROM company 
    JOIN offer ON company.id = offer.company_id 
    JOIN skill ON offer.id = skill.offer_id 
    WHERE 
      skill.name ILIKE '%sql%'
      OR skill.name ILIKE '%database%'
  )
