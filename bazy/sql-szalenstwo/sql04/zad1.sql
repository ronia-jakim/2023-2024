SELECT * 
FROM company_branch
WHERE 
  id = 699999;

BEGIN;
INSERT INTO company_branch VALUES(699999, 69, 'weles', 'weles', 'weles', 'weles', 'weles');
ROLLBACK;

SELECT * 
FROM company_branch
WHERE 
  id = 699999;

