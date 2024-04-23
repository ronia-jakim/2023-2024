WITH snow AS (
  SELECT offer_id, name 
  FROM skill 
  WHERE skill.name = 'Snowflake'
),
  cities AS (
    SELECT company_branch.city 
    FROM company_branch 
      JOIN offer ON offer.company_id = company_branch.company_id
    GROUP BY company_branch.city
    ORDER BY count(offer.id) DESC
    LIMIT 10
)
SELECT company_branch.city, count(snow.name) 
FROM cities 
  JOIN company_branch ON cities.city = company_branch.city 
  JOIN offer ON offer.company_branch_id = company_branch.id 
  LEFT JOIN snow ON snow.offer_id = offer.id
GROUP BY company_branch.city
ORDER BY 2 DESC, 1
