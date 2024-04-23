SELECT skill.name, 
  count(DISTINCT offer.title) AS stanowiska, 
  count(DISTINCT offer.id) AS oferty, 
  min(skill.value) AS min, 
  max(skill.value) AS max,
  round(avg(skill.value)) as avg
FROM skill 
  LEFT JOIN offer ON skill.offer_id = offer.id
GROUP BY skill.name
ORDER BY 2 DESC, 3 DESC
