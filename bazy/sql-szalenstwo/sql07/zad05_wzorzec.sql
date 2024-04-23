WITH cities AS (
SELECT city
FROM company_branch cb JOIN
offer o ON cb.id=o.company_branch_id
GROUP BY city
ORDER BY count(o.id) DESC
LIMIT 10),
snowflakeSkill AS (
SELECT name,
offer_id
FROM skill
WHERE name = 'Snowflake')
SELECT cb.city,
count(s.name)
FROM cities c JOIN
company_branch cb on c.city=cb.city JOIN
offer o ON o.company_branch_id = cb.id LEFT JOIN
snowflakeSkill s ON (o.id=s.offer_id)
GROUP BY cb.city
ORDER BY 2 DESC, 1;
