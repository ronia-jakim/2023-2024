
--setup
CREATE TABLE weles_dep (
  hours integer
);
CREATE TABLE weles_emp (
  hours integer
);

 insert into weles_dep values (69);
 insert into weles_dep values (42);
 insert into weles_emp values (100);
 insert into weles_emp values (11);


--t1
marudka=# BEGIN ISOLATION LEVEL READ COMMITTED ;
marudka=# BEGIN ISOLATION LEVEL READ COMMITTED ;

--t2
marudka=# BEGIN ISOLATION LEVEL READ COMMITTED ;
BEGIN
marudka=*# update weles_emp set hours = hours +1;
UPDATE 2
marudka=*# update weles_dep set hours = hours +1;
UPDATE 2
marudka=*# commit;
COMMIT
marudka=# 

--t1
marudka=*# select sum(hours) from weles_dep ;
 sum 
-----
 113
(1 row)
commit;


-- Powinno byc REPEATABLE READ
