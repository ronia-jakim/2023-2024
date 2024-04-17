DROP TABLE salary;

CREATE TABLE salary (
  salary_from DECIMAL NOT NULL,
  salary_to DECIMAL NOT NULL,
  offer_id INTEGER REFERENCES offer(id) NOT NULL,
  type TEXT,
  currency TEXT
);

--SELECT * FROM offer

INSERT INTO salary (
SELECT offer.salary_from_b2b :: DECIMAL,
       offer.salary_to_b2b :: DECIMAL,
       offer.id :: INTEGER AS offer_id,
       'b2b' AS type,
       offer.salary_currency_b2b :: TEXT AS currency
  FROM offer
  WHERE offer.if_b2b
);

INSERT INTO salary (
SELECT offer.salary_from_mandate :: DECIMAL,
       offer.salary_to_mandate :: DECIMAL,
       offer.id :: INTEGER AS offer_id,
       'mandate' AS type,
       offer.salary_currency_mandate :: TEXT AS currency
  FROM offer
  WHERE offer.if_mandate
);

INSERT INTO salary (
SELECT offer.salary_from_permanent :: DECIMAL,
       offer.salary_to_permanent :: DECIMAL,
       offer.id :: INTEGER AS offer_id,
       'permament' AS type,
       offer.salary_currency_permanent :: TEXT AS currency
  FROM offer
  WHERE offer.if_permanent
);

