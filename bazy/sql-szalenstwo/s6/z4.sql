CREATE TABLE plan (
  teacher integer, 
  course integer, 
  hours integer);

INSERT INTO plan (teacher, course, hours) VALUES (9, 10, 11), (69, 1, 42), (100, 69, 69), (420, 99, 23), (70, 2, 5);

-- nie dziala dla read commited i repeatable reads  (bo działa, co tutaj jest zle z powodu tego, ze asum w obu bylo ok, ale po commitach bylo za duzo, jak lekarze z prezentacji), ale ładnie się wypierdoli dla serializable
-- nowe inserty sa przezroczyste
