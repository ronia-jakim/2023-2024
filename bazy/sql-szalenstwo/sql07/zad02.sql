SELECT offer.title,
       count(DISTINCT skill.name),
       (array_agg(DISTINCT skill.name)) [1:4] AS example_skill
FROM offer
  JOIN skill ON offer.id = skill.offer_id 
GROUP BY offer.title 
HAVING count(DISTINCT skill.name) > 20
ORDER BY 2 DESC, 1
