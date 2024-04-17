SELECT salary_from_b2b + salary_to_b2b::DECIMAL FROM offer;

ALTER TABLE offer 
  ALTER COLUMN salary_from_b2b TYPE DECIMAL USING salary_from_b2b::DECIMAL;
